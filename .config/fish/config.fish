set -U FZF_LEGACY_KEYBINDINGS 0
set -U FZF_REVERSE_ISEARCH_OPTS "--reverse --height=100%"

set -x set LC_ALL en_JP

#set PATH $HOME/bin $HOME/.anyenv/bin $PATH
#eval (anyenv init - fish | source)

set -x PATH $GOPATH/bin $PATH

# Lima
set -x DOCKER_HOST unix://$HOME/.lima/dev1/sock/docker.sock 
# Colima
#set -x DOCKER_HOST unix://$HOME/.colima/default/docker.sock
set -x DOCKER_BUILDKIT 1

alias vi 'nvim'
alias vim 'nvim'
alias vimdiff 'nvim -d'
alias sed 'gsed'
alias dbash 'docker exec -it (docker ps --format "table {{.Names}}\t{{.Image}}" | fzf | awk \'{print $1}\') /bin/bash'


# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# asdf
#source /usr/local/opt/asdf/libexec/asdf.fish
#. ~/.asdf/plugins/golang/set-env.fish
#. ~/.asdf/plugins/java/set-java-home.fish
#set --export RUST_WITHOUT rust-docs


# mise
#~/.local/bin/mise activate fish | source



# pnpm
set -gx PNPM_HOME "/Users/h2-wada/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# Zellij
# The following snippet is meant to be used like this in your fish config:
#
# if status is-interactive
#     # Configure auto-attach/exit to your likings (default is off).
#     # set ZELLIJ_AUTO_ATTACH true
#     # set ZELLIJ_AUTO_EXIT true
#     eval (zellij setup --generate-auto-start fish | string collect)
# end
if not set -q ZELLIJ
    if test "$ZELLIJ_AUTO_ATTACH" = "true"
        zellij attach -c
    else
        zellij
    end

    if test "$ZELLIJ_AUTO_EXIT" = "true"
        kill $fish_pid
    end
end

