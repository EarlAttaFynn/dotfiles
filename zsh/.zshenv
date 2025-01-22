####################
# .zshenv
# ##################
export EDITOR="nvim"
export PAGER="less"
export BAT_PAGER="bat -p"
export MANPAGER="sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -l man'"

export KIND_EXPERIMENTAL_PROVIDER=podman

# FZF
export FZF_DEFAULT_COMMAND="fd -H --type f"
export FZF_DEFAULT_OPTS="
--layout=reverse
--info=inline
--height=80%
--multi
--prompt='∼ ' --pointer='▶' --marker='✓'
--preview 'bat --style=numbers --color=always {}'
--bind '?:toggle-preview'
--bind 'ctrl-a:select-all'
--bind 'ctrl-y:execute-silent(echo {+} | xclip -selection clipboard)+abort'
--bind 'ctrl-alt-y:execute(readlink -f {} | echo {+} | xclip -selection clipboard)+abort'
--bind 'ctrl-e:execute(echo {+} | xargs -o nvim)'
--bind 'ctrl-v:execute(code {+})'
--bind 'focus:transform-header:file --brief {}'
"
###################
# $PATH
###################
# go
export GOPATH='/var/home/eattafynn/go'
export PATH=$PATH:$GOPATH/bin
export PATH=$HOME/.local/bin/:$HOME/.local/share/bin/:$PATH
# cargo: last because script pre and post-pends the directory
. "$HOME/.cargo/env"
##################

