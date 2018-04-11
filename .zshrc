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

alias vi='nvim'
alias vim='nvim'
# Need blank for alias
alias sudo='sudo -E '
#alias docker='sudo docker'
alias pbcopy='win32yank.exe -i'
alias pbpaste='win32yank.exe -o'

export EDITOR=nvim
export VISUAL=nvim
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export GOPATH=$HOME/dev
export PATH=$PATH:$GOPATH/bin:/usr/local/go/bin

[ -n "$XTERM_VERSION" ] && transset-df -a >/dev/null
export TERMINAL=termite

if which fzf &> /dev/null; then
  function ghq-fzf() {
    local selected_dir=$(ghq list | fzf --query="$LBUFFER")
  
    if [ -n "$selected_dir" ]; then
      BUFFER="cd $(ghq root)/${selected_dir}"
      zle accept-line
    fi
  
    zle reset-prompt
  }
  
  zle -N ghq-fzf
  bindkey "^]" ghq-fzf

  #tmux
  if [[ ! -n $TMUX ]]; then
    # get the IDs
    ID="`tmux list-sessions`"
    if [[ -z "$ID" ]]; then
      tmux new-session
    fi
    create_new_session="Create New Session"
    ID="$ID\n${create_new_session}:"
    ID="`echo $ID | fzf | cut -d: -f1`"
    if [[ "$ID" = "${create_new_session}" ]]; then
      tmux new-session
    elif [[ -n "$ID" ]]; then
      tmux attach-session -t "$ID"
    else
      :  # Start terminal normally
    fi
  fi

  # fbr - checkout git branch
  fbr() {
    local branches branch
    branches=$(git branch -vv) &&
    branch=$(echo "$branches" | fzf +m) &&
    git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
  }

  # fshow - git commit browser
  fshow() {
    git log --graph --color=always \
        --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
    fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
        --bind "ctrl-m:execute:
                  (grep -o '[a-f0-9]\{7\}' | head -1 |
                  xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                  {}
  FZF-EOF"
  }
  
  # fd - cd to selected directory
  fd() {
    local dir
    dir=$(find ${1:-.} -path '*/\.*' -prune \
                    -o -type d -print 2> /dev/null | fzf +m) &&
    cd "$dir"
  }
fi

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



# http://hogem.hatenablog.com/entry/20090411/1239451878
# Ctrl+s
stty stop undef
# Ctrl+q
stty start undef

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

