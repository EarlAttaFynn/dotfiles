
export FZF_DEFAULT_OPTS="--preview 'bat --color=always {}'"
export FZF_DEFAULT_COMMAND="fd -H --type f"
export EDITOR="nvim"
export PAGER="bat"

# $PATH
export PATH=$HOME/.local/bin/:$HOME/.local/share/bin/:$PATH

# last because script pre and post-pends the directory
. "$HOME/.cargo/env"
