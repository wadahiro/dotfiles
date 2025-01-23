set -U FZF_LEGACY_KEYBINDINGS 0
set -U FZF_REVERSE_ISEARCH_OPTS "--reverse --height=100%"

set -x set LC_ALL en_JP

#set PATH $HOME/bin $HOME/.anyenv/bin $PATH
#eval (anyenv init - fish | source)

set -x PATH $GOPATH/bin $PATH

# Lima
#set -x DOCKER_HOST unix:///Users/$HOME/.lima/default/sock/docker.sock 
# Colima
set -x DOCKER_HOST unix://$HOME/.colima/default/docker.sock
set -x DOCKER_BUILDKIT 1

alias vi 'nvim'
alias vim 'nvim'
alias vimdiff 'nvim -d'
alias sed 'gsed'


# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# asdf
source /usr/local/opt/asdf/libexec/asdf.fish
. ~/.asdf/plugins/golang/set-env.fish
. ~/.asdf/plugins/java/set-java-home.fish
set --export RUST_WITHOUT rust-docs

