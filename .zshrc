# ENV Variables/PATHs
export ZSH="$HOME/.oh-my-zsh"
export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"

# ansible+pip binaries
if ! echo $PATH | grep -q "/home/naqa/.local/bin"; then
    export PATH=$PATH:/home/naqa/.local/bin
fi

if ! echo $PATH | grep -q "/mnt/c/Program Files/Oracle/VirtualBox"; then
    export PATH="$PATH:/mnt/c/Program Files/Oracle/VirtualBox"
fi

# ${=do}
export do="--dry-run=client -o yaml"

# Theme
ZSH_THEME="agnoster"

# ZSH Setup
plugins=(
    zsh-z
    git
    kubectl
    vagrant
    sudo
    docker
    docker-compose
    ansible
    terraform
    zsh-autosuggestions
    you-should-use
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Disable Windows beep
setopt NO_BEEP

# AWS autocomplete
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
complete -C '/usr/local/bin/aws_completer' aws

# Env Variables
# Extra more custom ENV variables
[[ -f ~/.zsh/envs.zsh ]] && source ~/.zsh/envs.zsh

# Aliases and Functions
[[ -f ~/.zsh/aliases.zsh ]] && source ~/.zsh/aliases.zsh
[[ -f ~/.zsh/functions.zsh ]] && source ~/.zsh/functions.zsh

# Setup Fuzzy Finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
