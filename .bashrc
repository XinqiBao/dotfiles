#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PATH=${HOME}/.local/opt/node/bin:${PATH}
export PATH=${HOME}/.local/bin:${PATH}
export PATH=${HOME}/tool:${PATH}

alias ls='ls --color=auto'
alias ll='ls --color=auto -lhrt'
alias vim='nvim'
alias vimdiff='nvim -d'

export EDITOR=nvim
export BROWSER=firefox
export TERM=xterm-256color
export PS1="[\[\e[36;1m\]\u@\h \[\e[32;1m\]\w\[\e[m\]]\[\e[33m\](\$(git branch 2>/dev/null | grep '^*' | colrm 1 2))\n\[\e[m\]~~~>\$ "

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}'"

ulimit -c unlimited

<<COMMENT
export proxy_url=http://localhost:1080
export http_proxy=$proxy_url
export https_proxy=$proxy_url
export HTTP_PROXY=$proxy_url
export HTTPS_PROXY=$proxy_url
COMMENT

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
