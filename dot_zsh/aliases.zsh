#Basics
alias ls="eza --icons --group-directories-first"
alias ll="eza -l --icons -s time"
alias la="eza -a --icons"
alias cat='bat --paging never --theme base16 --style plain'
alias vi='vim'
alias catssh='cat ~/.ssh/config'
alias vimssh='vim ~/.ssh/config'
alias vimzsh='vim ~/.zshrc'
alias vimbash='vim ~/.bashrc'
alias vimaliases='vim ~/.zsh/aliases.zsh'
alias vimenv='vim ~/.zsh/env.zsh'
alias ansible-hosts='ansible-inventory --graph'
alias grep='grep -i --color'
alias pip='pip3'
alias python='python3'

# Kubernetes
alias kg='kubecolor get'
alias kgn='kubecolor get nodes'
alias h='helm'
alias kx='kubectx'
alias kn='kubens'

# AWS
alias cataws='cat ~/.aws/config'
alias vimaws='vim ~/.aws/config'
alias loginaws='aws sso login; aws configure list-profiles'
alias profilesaws='aws configure list-profiles'

# Docker
alias dockip='for i in $(docker ps -q); do docker inspect -f "{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}} - {{.Name}}" $i;done'
