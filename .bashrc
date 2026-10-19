#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PATH="${HOME}/.local/opt/node/bin:${PATH}"
export PATH="${HOME}/.local/bin:${PATH}"
export PATH="${HOME}/tool:${PATH}"

# Let mise take precedence over Cargo and local tools.
[ -f "${HOME}/.cargo/env" ] && . "${HOME}/.cargo/env"
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate bash)"
fi

alias ls='ls --color=auto'
alias ll='ls -lhrt'

alias vim='nvim'
alias vimdiff='nvim -d'
export EDITOR=nvim

PS1='[\[\e[36;1m\]\u@\h \[\e[32;1m\]\w\[\e[m\]]\[\e[33m\]($(git symbolic-ref --quiet --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null))\n\[\e[m\]~~~>\$ '

ulimit -c unlimited

#export proxy_url=http://localhost:1080
#export http_proxy=$proxy_url
#export https_proxy=$proxy_url
#export HTTP_PROXY=$proxy_url
#export HTTPS_PROXY=$proxy_url

# fzf key bindings and completion
eval "$(fzf --bash)"
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}'"

if [[ -z ${DISPLAY:-} && -z ${WAYLAND_DISPLAY:-} && ${XDG_VTNR:-} == 1 ]]; then
  exec startx
fi
