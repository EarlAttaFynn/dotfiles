#######################
# .zshrc
# #####################
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

# Autocomplete
source <(fzf --zsh)
source <(kubectl completion zsh)
# Manually load plugins
source ~/dotfiles/zsh/.zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source ~/dotfiles/zsh/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh

# Aliases
source ~/dotfiles/zsh/.zsh_aliases

# Initialize starship prompt
eval "$(starship init zsh)"

# fastfetch for status
fastfetch

# Initialize ssh agent
# eval "$(ssh-agent -s)"

# start j directory jump script
# [[ -f /usr/share/autojump/autojump.zsh ]] && source /usr/share/autojump/autojump.zsh
# zoxide instead of autojump
eval "$(zoxide init zsh)"
