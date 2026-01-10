# FZF settings
set -U FZF_LEGACY_KEYBINDINGS 0
set -U FZF_REVERSE_ISEARCH_OPTS "--reverse --height=100%"

# Locale
set -x LC_ALL en_JP

# PATH
set -x PATH $HOME/.local/share/nvim/mason/bin $GOPATH/bin $PATH
fish_add_path $HOME/Library/pnpm

# Aliases
alias vi 'nvim'
alias vim 'nvim'
alias vimdiff 'nvim -d'
alias sed 'gsed'
alias dbash 'docker exec -it (docker ps --format "table {{.Names}}\t{{.Image}}" | fzf | awk \'{print $1}\') /bin/bash'

# Docker
set -x DOCKER_BUILDKIT 1

# Zellij auto-start
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

# Load local configuration (not tracked in git)
if test -f ~/.config/fish/config.local.fish
    source ~/.config/fish/config.local.fish
end
