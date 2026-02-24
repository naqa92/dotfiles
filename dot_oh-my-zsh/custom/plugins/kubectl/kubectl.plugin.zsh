# Custom kubectl overrides — loaded INSTEAD of the built-in kubectl plugin
# (oh-my-zsh gives priority to custom/plugins/ over plugins/)

# Source the original plugin first
source "$ZSH/plugins/kubectl/kubectl.plugin.zsh"

# Override kubectl with kubecolor when available
function kubectl() {
  if command -v kubecolor >/dev/null 2>&1; then
    kubecolor "$@"
  else
    command kubectl "$@"
  fi
}

# Override k to use kubecolor too
function k() {
  if command -v kubecolor >/dev/null 2>&1; then
    kubecolor "$@"
  else
    command kubectl "$@"
  fi
}
