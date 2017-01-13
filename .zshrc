#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

#. /usr/lib/python3.5/site-packages/powerline/bindings/zsh/powerline.zsh

alias vi='vim'
alias sudo='sudo -E'
#alias docker='sudo docker'
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

export GOPATH=$HOME
export PATH=$PATH:$GOPATH/bin

[ -n "$XTERM_VERSION" ] && transset-df -a >/dev/null
export TERMINAL=termite

function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src
