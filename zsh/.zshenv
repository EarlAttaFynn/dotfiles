
export EDITOR="nvim"
export PAGER="bat"
#export FZF_DEFAULT_OPTS_FILE="$HOME/.config/fzf/.fzfrc"
export FZF_DEFAULT_COMMAND="fd -H --type f"
export FZF_DEFAULT_OPTS="
--preview 'bat --color=always {}' \
--bind 'focus:transform-header:file --brief {}'"

# $PATH
export PATH=$HOME/.local/bin/:$HOME/.local/share/bin/:$PATH

# last because script pre and post-pends the directory
. "$HOME/.cargo/env"
