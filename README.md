# dotfiles

### Basic tools
```sh
sudo apt install -y zip unzip curl dnsutils iftop software-properties-common git vim tree net-tools telnet gnupg2 peco exa python3-pip pipx jq yq bat
```

### Gum (for shell scripts)

```sh
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg | sh; 
sudo chmod a+r /etc/apt/keyrings/charm.gpg
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
sudo apt update && sudo apt install -y gum
```

### Ansible + pipx binaries

```sh
pipx install --include-deps ansible
pipx install ansible-lint
pipx install openstacksdk
pipx install python-openstackclient
pipx install poetry
```

>*Nécessite: `export PATH="$HOME/.local/bin:$PATH"` (voir .zshrc)*

>*Note: Pour les librairies (ex: pydot, passlib, requests...) utiliser pip dans un venv*

>*Upgrade: `pipx upgrade --include-injected ansible`*

### Fuzzy finders
```sh
wget https://github.com/junegunn/fzf/releases/download/v0.60.3/fzf-0.60.3-linux_amd64.tar.gz
sudo tar -C /usr/bin -xzf fzf-0.60.3-linux_amd64.tar.gz && rm fzf-0.60.3-linux_amd64.tar.gz
```

>*Nécessite: `source <(fzf --zsh)` (voir .zshrc)*

### [Minikube](https://kubernetes.io/fr/docs/tasks/tools/install-minikube/)
```sh
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube
sudo mkdir -p /usr/local/bin/
sudo install minikube /usr/local/bin/ && rm minikube
```

### [Kubectl](https://kubernetes.io/fr/docs/tasks/tools/install-kubectl/Kubectl)
```sh
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && rm kubectl
```

### [Helm](https://helm.sh/docs/intro/install/)
```sh
sudo curl -sL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```

### K8S other tools : kubens, kubectx, k9s
```sh
sudo curl -fsSL "https://github.com/ahmetb/kubectx/releases/latest/download/kubens" -o /usr/local/bin/kubens && sudo chmod +x /usr/local/bin/kubens
sudo curl -fsSL "https://github.com/ahmetb/kubectx/releases/latest/download/kubectx" -o /usr/local/bin/kubectx && sudo chmod +x /usr/local/bin/kubectx
wget -qq "https://github.com/derailed/k9s/releases/latest/download/k9s_Linux_amd64.tar.gz" && sudo tar -C /usr/local/bin k9s -xzf k9s_Linux_amd64.tar.gz && rm k9s_Linux_amd64.tar.gz
```

### [Krew + plugins](https://krew.sigs.k8s.io/)

```sh
(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew && rm -f "${KREW}" "${KREW}.tar.gz" LICENSE
)
kubectl krew install cnpg klock view-secret stern
```

>*Nécessite: `export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"` (.zshrc)*

>*Upgrade: `kubectl krew upgrade`*

### gitlab-ci-local
```sh
sudo wget -O /etc/apt/sources.list.d/gitlab-ci-local.sources https://gitlab-ci-local-ppa.firecow.dk/gitlab-ci-local.sources
sudo apt update && sudo apt install -y gitlab-ci-local
```

### Go
```sh
wget -q https://go.dev/dl/go1.24.1.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.24.1.linux-amd64.tar.gz && rm go1.24.1.linux-amd64.tar.gz
```

>*Nécessite: `export PATH="/usr/local/go/bin:$PATH"` (voir .zshrc)*

### [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) et [Vagrant + plugins](https://dev.to/sfpear/vagrant-and-virtualbox-on-windows-11-and-wsl2-395p)

>*Pré-requis: Installer VirtualBox 7.0 (Windows) et le pack d'extension pour Vagrant*

```sh
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install -y terraform vagrant
vagrant plugin install virtualbox_WSL2 vagrant-faster vagrant-cachier
```

>*Vagrant - Nécessite: `export PATH="/mnt/c/Program Files/Oracle/VirtualBox:$PATH"` (voir .zshrc)*

_> [Vagrant - Fixing Issues](https://thedatabaseme.de/2022/02/20/vagrant-up-running-vagrant-under-wsl2/)_

### PostgreSQL Client

```sh
wget -qq -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo gpg --dearmor -o /etc/apt/keyrings/postgresql.gpg
echo "deb [signed-by=/etc/apt/keyrings/postgresql.gpg] http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list
sudo apt update && sudo apt install -y postgresql-client-17
```

### Tailwind CSS

```sh
curl -sLO "https://github.com/tailwindlabs/tailwindcss/releases/latest/download/tailwindcss-linux-x64"
chmod +x tailwindcss-linux-x64
sudo mv tailwindcss-linux-x64 /usr/local/bin/tailwindcss
```

### [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

```sh
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install && rm -r aws awscliv2.zip
```

>*Configuration CLI: `aws configure`*

### ArgoCD + Argo Rollouts CLI

```sh
sudo wget -qq https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64 -O /usr/local/bin/argocd
sudo chmod +x /usr/local/bin/argocd

sudo curl -sL https://github.com/argoproj/argo-rollouts/releases/latest/download/kubectl-argo-rollouts-linux-amd64 -o /usr/local/bin/kubectl-argo-rollouts
sudo chmod +x /usr/local/bin/kubectl-argo-rollouts
```

### Act (Github Actions local)

```sh
wget -qq -O - https://raw.githubusercontent.com/nektos/act/master/install.sh | bash
```

### ZSH + OhMyZSH
```sh
sudo apt install -y zsh # install zsh
sudo chsh -s $(which zsh) $USER    # shell zsh par défaut
echo "y" | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" # install ohmyzsh + default shell to zsh
exec zsh  # reload
```

### ZSH plugins
```sh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

### chezmoi

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin
chezmoi init
```

---

# Commands

### FZF - Fuzzy Search
```sh
^r  # Searches command history
^t  # Searches directories
```

### Zsh-Z
```sh
z # Show all paths
z $DIR_PATH # Searches frequently access directory
z --add $DIR_PATH # Add an additional path (ex: /mnt/c/Users/$USER/Desktop)
```

### Split Windows Terminal

Raccourcis

```sh
Splitter verticalement : Alt + Shift + +
Splitter horizontalement : Alt + Shift + -
Changer de panneau actif : Alt + Flèche directionnelle (← ↑ ↓ →)
Redimensionner les panneaux : Alt + Shift + Flèche directionnelle (← ↑ ↓ →)
Fermer le panneau actif : Ctrl + Maj + W
```

---

# Update dotfiles

changements locaux :

```sh
chezmoi add ~/.zshrc
chezmoi cd # ~/.local/share/chezmoi/
git add .
git commit -m "add .zshrc"
git push
```


re-appliquer les dotfiles ailleurs :

```sh
chezmoi init --apply $GITHUB_USERNAME
```
