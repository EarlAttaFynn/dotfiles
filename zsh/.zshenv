####################
# .zshenv
# ##################
export TERM='xterm-256color'
export EDITOR="nvim"
export PAGER="less"
# export BAT_PAGER="bat -p"
# export MANPAGER="sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -l man'"

export KIND_EXPERIMENTAL_PROVIDER=podman

# FZF
export FZF_DEFAULT_COMMAND="fd -H --type f"
export FZF_DEFAULT_OPTS="
--ansi
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
#export GOPATH='/var/home/eattafynn/go'
#export PATH=$PATH:$GOPATH/bin
#export PATH=$PATH:$HOME/.local/bin/:$HOME/.local/share/bin/
# cargo: last because script pre and post-pends the directory
#. "$HOME/.cargo/env"
##################
#Manually setting path for now but flesh out this check and conditionally set env
# Check if we're inside a distrobox container
if [ -n "$DISTROBOX_NAME" ]; then
    # Inside a distrobox, add exports specific to the container environment
    # Don't set system bus address globally as it creates unwanted behavior with package managers
else
    # Not inside a distrobox, add exports specific to the host environment
fi

#export PKG_CONFIG_PATH=/usr/lib64/pkgconfig:/usr/share/pkgconfig:$PKG_CONFIG_PATH
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$HOME/.local/bin/:$HOME/.local/share/bin/:$HOME/.cargo/bin/:$HOME/go/bin"

# for virtualization with socketbased libvirt
export LIBVIRT_DEFAULT_URI=qemu:///system

