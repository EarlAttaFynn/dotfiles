# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd beep extendedglob nomatch notify
# End of lines configured by zsh-newuser-install
#
# Include history in child shells
setopt inc_append_history
# Enable vi mode
bindkey -v
# The following lines were added by compinstall
zstyle :compinstall filename '/var/home/eattafynn/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Manually load plugins
source <(fzf --zsh)
source ~/dotfiles/zsh/.zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source ~/dotfiles/zsh/.zsh_aliases
# Initialize starship prompt
eval "$(starship init zsh)"

# fastfetch
fastfetch

# Initialize ssh agent
eval "$(ssh-agent -s)"

# start z directory jump script
source ~/.local/share/z/z.sh
