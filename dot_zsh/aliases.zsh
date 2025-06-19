#Basics
alias ls="eza --icons --group-directories-first"
alias ll="eza -l --icons -s time"
alias la="eza -a --icons"

alias cat='bat --paging never --theme base16 --style plain'
alias vi='vim'

alias sshconfig='cat ~/.ssh/config'
alias modssh='vi ~/.ssh/config'
alias modzsh='vi ~/.zshrc'
alias modbash='vi ~/.zshrc'
alias modalias='vi ~/.zsh/aliases.zsh'
alias modfunc='~/.zsh/functions.zsh'
alias modaws='vi ~/.aws/config'
alias hosts='ansible-inventory --graph'
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
alias awsconfig='cat ~/.aws/config'
alias awslogin='aws sso login; aws configure list-profiles'
alias awsprofiles='aws configure list-profiles'

# Docker
alias dockip='for i in $(docker ps -q); do docker inspect -f "{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}} - {{.Name}}" $i;done'
