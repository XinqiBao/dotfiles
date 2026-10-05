local treesitter = require('nvim-treesitter')

treesitter.setup {
  install_dir = vim.fn.stdpath('data') .. '/site',
}

treesitter.install {
  'bash',
  'c',
  'cmake',
  'cpp',
  'json',
  'lua',
  'markdown',
  'markdown_inline',
  'python',
  'query',
  'toml',
  'vim',
  'vimdoc',
  'yaml',
}

local function foldlevel(lnum, exclude_start)
  if lnum < 1 or lnum > vim.api.nvim_buf_line_count(0) then
    return 0
  end
  local value = vim.treesitter.foldexpr(lnum)
  local level = tonumber(value:match('%d+')) or 0
  -- A '>N' starts a new fold even when adjacent folds have the same level.
  return math.max(0, level - (exclude_start and value:sub(1, 1) == '>' and 1 or 0))
end

function _G.DotfilesFoldExpr()
  local line = vim.v.lnum
  -- Keep only levels spanning the previous, current, and next lines.
  -- Default foldminlines keeps interiors of fewer than two lines visible.
  return math.min(foldlevel(line - 1), foldlevel(line, true), foldlevel(line + 1, true))
end

local function enable(buf)
  vim.wo[0][0].foldexpr = '0'
  if not pcall(vim.treesitter.start, buf) then
    return
  end

  vim.wo[0][0].foldexpr = 'v:lua.DotfilesFoldExpr()'
  vim.wo[0][0].foldmethod = 'expr'
end

vim.api.nvim_create_autocmd('FileType', {
  callback = function(args) enable(args.buf) end,
})

-- Startup filetype detection can precede this config being sourced.
if vim.bo.filetype ~= '' then
  enable(0)
end
