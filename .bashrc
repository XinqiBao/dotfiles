#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls --color=auto -lhrt'
alias vim='nvim'
alias vimdiff='nvim -d'

export EDITOR=nvim
export PATH=$HOME/tool:$HOME/lib/grpc/bin:$PATH
export PS1="[\[\e[36;1m\]\u@\h \[\e[32;1m\]\w\[\e[m\]]\[\e[33m\](\$(git branch 2>/dev/null | grep '^*' | colrm 1 2))\n\[\e[m\]~~~>\$ "
export TERM=xterm-256color

ulimit -c unlimited
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}'"

