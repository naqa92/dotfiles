# Palette Nord
NORD0="#2E3440"  # Fond noir/gris foncé
NORD1="#3B4252"  # Gris foncé
NORD2="#434C5E"  # Gris
NORD3="#4C566A"  # Gris clair
NORD4="#D8DEE9"  # Blanc cassé
NORD5="#E5E9F0"  # Blanc neige
NORD6="#ECEFF4"  # Blanc brillant
NORD7="#8FBCBB"  # Cyan glacé
NORD8="#88C0D0"  # Bleu ciel
NORD9="#81A1C1"  # Bleu
NORD10="#5E81AC" # Bleu foncé
NORD11="#BF616A" # Rouge
NORD12="#D08770" # Orange
NORD13="#EBCB8B" # Jaune
NORD14="#A3BE8C" # Vert
NORD15="#B48EAD" # Violet

CURRENT_BG='NONE'

KUBE_PS1_SYMBOL_COLOR=blue
KUBE_PS1_CTX_COLOR=magenta
KUBE_PS1_NS_COLOR=cyan
KUBE_PS1_SYMBOL_CUSTOM=img
KUBE_PS1_PREFIX=''
KUBE_PS1_SUFFIX=''

case ${SOLARIZED_THEME:-dark} in
    light) CURRENT_FG=$NORD6;;
    *)     CURRENT_FG=$NORD0;;
esac

# Special Powerline characters

() {
  local LC_ALL="" LC_CTYPE="en_US.UTF-8"
  SEGMENT_SEPARATOR=$'\ue0b4'
  LEFT_SEGMENT_SEPARATOR=$'\ue0b6'
}

prompt_start() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n "%{$bg%F{$CURRENT_BG}%}$LEFT_SEGMENT_SEPARATOR%{$fg%}"
  else
    echo -n "%{$bg%}%{$fg%}"
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n "$3"
}

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
  else
    echo -n "%{$bg%}%{$fg%} "
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}

# Ajoute un saut de ligne avant l'affichage du prompt
precmd() {
  print ""
}

### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown

# Context: user@hostname (who am I and where am I)
prompt_context() {
  if [[ "$USERNAME" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment $NORD4 $NORD0 "%(!.%{%F{yellow}%}.)%n@%m"
  fi
}

# Git: branch/detached head, dirty status
prompt_git() {
  (( $+commands[git] )) || return
  if [[ "$(command git config --get oh-my-zsh.hide-status 2>/dev/null)" = 1 ]]; then
    return
  fi
  local PL_BRANCH_CHAR
  () {
    local LC_ALL="" LC_CTYPE="en_US.UTF-8"
    PL_BRANCH_CHAR=$'\uf126'
  }
  local ref dirty mode repo_path

   if [[ "$(command git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ]]; then
    repo_path=$(command git rev-parse --git-dir 2>/dev/null)
    dirty=$(parse_git_dirty)
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref="◈ $(command git describe --exact-match --tags HEAD 2> /dev/null)" || \
    ref="➦ $(command git rev-parse --short HEAD 2> /dev/null)"
    if [[ -n $dirty ]]; then
      prompt_segment $NORD13 $NORD0
    else
      prompt_segment $NORD14 $CURRENT_FG
    fi

    local ahead behind
    ahead=$(command git log --oneline @{upstream}.. 2>/dev/null)
    behind=$(command git log --oneline ..@{upstream} 2>/dev/null)
    if [[ -n "$ahead" ]] && [[ -n "$behind" ]]; then
      PL_BRANCH_CHAR=$'\u21c5'
    elif [[ -n "$ahead" ]]; then
      PL_BRANCH_CHAR=$'\u21b1'
    elif [[ -n "$behind" ]]; then
      PL_BRANCH_CHAR=$'\u21b0'
    fi

    if [[ -e "${repo_path}/BISECT_LOG" ]]; then
      mode=" <B>"
    elif [[ -e "${repo_path}/MERGE_HEAD" ]]; then
      mode=" >M<"
    elif [[ -e "${repo_path}/rebase" || -e "${repo_path}/rebase-apply" || -e "${repo_path}/rebase-merge" || -e "${repo_path}/../.dotest" ]]; then
      mode=" >R>"
    fi

    setopt promptsubst
    autoload -Uz vcs_info

    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' get-revision true
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' stagedstr '✚'
    zstyle ':vcs_info:*' unstagedstr '±'
    zstyle ':vcs_info:*' formats ' %u%c'
    zstyle ':vcs_info:*' actionformats ' %u%c'
    vcs_info
    echo -n "${${ref:gs/%/%%}/refs\/heads\//$PL_BRANCH_CHAR }${vcs_info_msg_0_%% }${mode}"
  fi
}

# Dir: current working directory
prompt_dir() {
  prompt_segment $NORD10 $NORD0 '\uf115  %c'
}

# Virtualenv: current working virtualenv
prompt_virtualenv() {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    prompt_segment $NORD7 $NORD0 "🐍 ${VIRTUAL_ENV:t}"
  fi
}

# Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
  local -a symbols

  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{$NORD11}%}✘"
  [[ $UID -eq 0 ]] && symbols+="%{%F{$NORD13}%}⚡"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{$NORD7}%}⚙"

  [[ -n "$symbols" ]] && prompt_segment $NORD0 default "$symbols"
}

#AWS Profile:
# - display current AWS_PROFILE name
# - displays yellow on red if profile name contains 'production' or
#   ends in '-prod'
# - displays black on green otherwise
prompt_aws() {
  [[ -z "$AWS_PROFILE" || "$SHOW_AWS_PROMPT" = false ]] && return
  case "$AWS_PROFILE" in
    *-prod|*production*) prompt_segment $NORD11 $NORD13 "AWS: ${AWS_PROFILE:gs/%/%%}" ;;
    *) prompt_segment $NORD14 $NORD0 "AWS: ${AWS_PROFILE:gs/%/%%}" ;;
  esac
}

prompt_kube_ps1() {
  # Récupère la sortie de kube_ps1
  local kube_segment="$(kube_ps1)"
  # Si kube_ps1 retourne du contenu, affiche le segment
  if [[ -n $kube_segment ]]; then
    prompt_segment $NORD3 $NORD0 "$kube_segment"
  fi
}

## Main prompt
build_prompt() {
  RETVAL=$?
  prompt_start
  prompt_status
  prompt_virtualenv
  prompt_aws
  #prompt_context
  prompt_kube_ps1
  prompt_dir
  prompt_git
  prompt_end
}

PROMPT='%{%f%b%k%}$(build_prompt)
%F{$NORD14} ➜%f '
