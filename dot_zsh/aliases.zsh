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
alias cl='claude'

# Kubernetes
alias kg='kubecolor get'
alias kgn='kubecolor get nodes'
alias h='helm'
alias kx='kubectx'
alias kn='kubens'
alias gonzo='k stern . | gonzo'
alias gonzo-vmlogs='gonzo --vmlogs-url="http://localhost:9428" --vmlogs-query="*"'
alias popeye='POPEYE_REPORT_DIR=$(pwd) popeye -A --save --out html --output-file report.html'

# AWS
alias cataws='cat ~/.aws/config'
alias vimaws='vim ~/.aws/config'
alias loginaws='aws sso login; aws configure list-profiles'
alias profilesaws='aws configure list-profiles'

# Docker
alias dockip='for i in $(docker ps -q); do docker inspect -f "{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}} - {{.Name}}" $i;done'

# Gitlab
alias glab-create-formation='glab project create --name $(basename $(pwd)) --group naqa92-formations --private && glab api "projects/naqa92-formations%2F$(basename $(pwd))" -X PUT --raw-field "ci_push_repository_for_job_token_allowed=true" > /dev/null && git add . && git commit -m "Initial commit" && git push --set-upstream origin main && echo "Projet créé et code poussé sur naqa92-formations/$(basename $(pwd)) (CI push activé)"'
alias glab-create-project='glab project create --name $(basename $(pwd)) --private && git add . && git commit -m "Initial commit [ci skip]" && git push --set-upstream origin main && echo "Projet créé et code poussé sur naqa92/$(basename $(pwd))"'

# Github
alias gh-create-project='git init && git add . && git commit -m "Initial commit [ci skip]" && gh repo create $(basename $(pwd)) --private --source=. --remote=origin --push && git remote set-url origin git@github.com:naqa92/$(basename $(pwd)).git && echo "Projet créé et code poussé sur naqa92/$(basename $(pwd))"'

# Claude
alias claude-update-commands='rsync -av /home/naqa/.claude/commands/ /home/naqa/formation-ia/.claude/commands/ && git -C ~/formation-ia add . && git -C ~/formation-ia diff --cached --quiet || (git -C ~/formation-ia commit -m "update commands" && git -C ~/formation-ia push)'
alias claude-update-skills='rsync -av /home/naqa/.claude/skills/ /home/naqa/formation-ia/.claude/skills/ && git -C ~/formation-ia add . && git -C ~/formation-ia diff --cached --quiet || (git -C ~/formation-ia commit -m "update skills" && git -C ~/formation-ia push)'
