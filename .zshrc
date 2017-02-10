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

# /usr/lib/python3.6/site-packages/powerline/bindings/zsh/powerline.zsh

alias vi='vim'
# Need blank for alias
alias sudo='sudo -E '
#alias docker='sudo docker'
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

export EDITOR=vim
export VISUAL=vim
export GOPATH=$HOME
export PATH=$PATH:$GOPATH/bin

[ -n "$XTERM_VERSION" ] && transset-df -a >/dev/null
export TERMINAL=termite

if which peco &> /dev/null; then
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

  # https://gist.github.com/yuttie/2aeaecdba24256c73bf2
  function peco-history-selection() {
    local tac
    { which gtac &> /dev/null && tac="gtac" } || \
      { which tac &> /dev/null && tac="tac" } || \
      tac="tail -r"
    BUFFER=$(fc -l -n 1 | eval $tac | \
                peco --layout=bottom-up --query "$LBUFFER")
    CURSOR=$#BUFFER # move cursor
    zle -R -c       # refresh
  }
  zle -N peco-history-selection
  bindkey '^R' peco-history-selection
fi

#tmux
if [[ ! -n $TMUX ]]; then
  # get the IDs
  ID="`tmux list-sessions`"
  if [[ -z "$ID" ]]; then
    tmux new-session
  fi
  create_new_session="Create New Session"
  ID="$ID\n${create_new_session}:"
  ID="`echo $ID | peco | cut -d: -f1`"
  if [[ "$ID" = "${create_new_session}" ]]; then
    tmux new-session
  elif [[ -n "$ID" ]]; then
    tmux attach-session -t "$ID"
  else
    :  # Start terminal normally
  fi
fi


# http://hogem.hatenablog.com/entry/20090411/1239451878
# Ctrl+s
stty stop undef
# Ctrl+q
stty start undef
source /usr/share/nvm/init-nvm.sh
