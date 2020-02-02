set -U FZF_LEGACY_KEYBINDINGS 0
set -U FZF_REVERSE_ISEARCH_OPTS "--reverse --height=100%"

set -x set LC_ALL en_JP

set PATH $HOME/bin $HOME/.anyenv/bin $PATH
anyenv init - fish | source

set -x PATH $GOPATH/bin $PATH

alias vi 'nvim'
alias vim 'nvim'
