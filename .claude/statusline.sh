#!/bin/bash
input=$(cat)

# ============================================================
# 数据提取
# ============================================================
MODEL=$(echo "$input" | jq -r '.model.display_name')
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
COST=$(echo "$input" | jq -r '.cost.total_cost_usd // 0' | xargs printf '%.2f')
ADDED=$(echo "$input" | jq -r '.cost.total_lines_added // 0')
REMOVED=$(echo "$input" | jq -r '.cost.total_lines_removed // 0')
API_MS=$(echo "$input" | jq -r '.cost.total_api_duration_ms // 0')
API_TOTAL_S=$((API_MS / 1000))
CWD=$(echo "$input" | jq -r '.cwd')
BRANCH=$(git -C "$CWD" --no-optional-locks branch --show-current 2>/dev/null)

# ============================================================
# 颜色定义
# ============================================================
R='\033[0m'
C_MODEL='\033[1;37m'    # 粗体白 - 模型名
C_CWD='\033[1;34m'      # 粗体蓝 - 工作目录
C_BRANCH='\033[36m'     # 青色   - git 分支
C_COST='\033[33m'       # 黄色   - 花费
C_DUR='\033[35m'        # 紫色   - 时长
C_ADD='\033[32m'        # 绿色   - 新增行
C_DEL='\033[31m'        # 红色   - 删除行
C_DIM='\033[90m'        # 灰色   - 进度条空白段

# 上下文颜色: < 70% 绿 | 70-89% 黄 | >= 90% 红
if [ "$PCT" -ge 90 ]; then C_CTX='\033[31m'
elif [ "$PCT" -ge 70 ]; then C_CTX='\033[33m'
else C_CTX='\033[32m'; fi

# ============================================================
# 进度条
# ============================================================
BAR_WIDTH=15
FILLED=$((PCT * BAR_WIDTH / 100))
EMPTY=$((BAR_WIDTH - FILLED))
BAR="${C_CTX}$(printf "%${FILLED}s" | tr ' ' '▓')${C_DIM}$(printf "%${EMPTY}s" | tr ' ' '░')${R}"

# ============================================================
# 分段构建 - 注释掉 seg_xxx 行即可关闭对应段
# ============================================================
SEP=" │ "
OUT=""
add() { [ -n "$OUT" ] && OUT="${OUT}${SEP}"; OUT="${OUT}$1"; }

# [1] 模型 + 版本
seg_model="${C_MODEL}${MODEL}"
add "$seg_model"

# [2] 工作目录 (~ 缩写, 最后两级)
SHORT_CWD=$(echo "$CWD" | sed "s|^$HOME|~|" | awk -F/ '{if(NF<=2)print $0; else printf "%s/%s",$((NF-1)),$NF}')
seg_cwd="${C_CWD}${SHORT_CWD}${R}"
add "$seg_cwd"

# [3] Git 分支
if [ -n "$BRANCH" ]; then
  seg_git="${C_BRANCH}⎇ ${BRANCH}${R}"
  add "$seg_git"
fi

# [4] 上下文进度条 + 百分比
seg_ctx="${BAR} ${C_CTX}${PCT}%%${R}"
add "$seg_ctx"

# [5] 花费
seg_cost="${C_COST}\$${COST}${R}"
add "$seg_cost"

# [6] 代码增删
seg_lines="${C_ADD}+${ADDED}${R} ${C_DEL}-${REMOVED}${R}"
add "$seg_lines"

# [7] API 耗时 (自动进位: s -> m s -> h m s)
if [ "$API_TOTAL_S" -ge 3600 ]; then
  seg_dur=$(printf "${C_DUR}%dh%dm%ds${R}" $((API_TOTAL_S/3600)) $((API_TOTAL_S%3600/60)) $((API_TOTAL_S%60)))
elif [ "$API_TOTAL_S" -ge 60 ]; then
  seg_dur=$(printf "${C_DUR}%dm%ds${R}" $((API_TOTAL_S/60)) $((API_TOTAL_S%60)))
else
  seg_dur=$(printf "${C_DUR}%d.%ds${R}" "$API_TOTAL_S" $(( (API_MS%1000)/100 )))
fi
add "$seg_dur"

# ============================================================
# 输出
# ============================================================
printf '%b\n' "$OUT"
