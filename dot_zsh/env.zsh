# Add custom ENV values here to export

# Vagrant
export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"
export VAGRANT_WSL_WINDOWS_ACCESS_USER_HOME_PATH="/mnt/c/Users/$USER/"

# Kubernetes 
export do="--dry-run=client -o yaml"  # ${=do}

# venv (géré par prompt agnoster)
export VIRTUAL_ENV_DISABLE_PROMPT=1

# devbox (géré par prompt agnoster)
export DEVBOX_NO_PROMPT=true

# WSL GPU (librocdxg)
export HSA_ENABLE_DXG_DETECTION=1

# Jetons de CLI d'agents, lus depuis ~/.config/brain-private (hors repos)
[ -r ~/.config/brain-private/notion-token ] && export NOTION_API_TOKEN="$(<~/.config/brain-private/notion-token)"
