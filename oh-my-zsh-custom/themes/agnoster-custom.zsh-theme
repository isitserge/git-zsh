# agnoster-custom.zsh-theme: Modern, context-rich, robust prompt

# Helper functions to produce status segments
prompt_git_info() {
  [[ "$(command git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ]] || return
  branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  state=$(git status --porcelain 2>/dev/null | grep -q . && echo "*" || echo "")
  [[ -n "$branch" ]] && echo " $branch$state"
}

prompt_python_venv() {
  [[ -n "$VIRTUAL_ENV" ]] && echo "🐍 ${VIRTUAL_ENV##*/}"
}

prompt_terraform() {
  if [[ -n "$TF_WORKSPACE" ]]; then
    echo "🌎 $TF_WORKSPACE"
  else
    tfenvfile=$(find . -type f -path '*/.terraform/environment' -print -quit 2>/dev/null)
    if [[ -n "$tfenvfile" ]]; then
      workspace=$(cat "$tfenvfile")
      echo "🌎 $workspace"
    elif find . -type d -name '.terraform' -print -quit | grep -q .; then
      echo "🌎 default"
    fi
  fi
}

prompt_node() {
  if [[ -f package.json || -d node_modules ]]; then
    nodev=$(node -v 2>/dev/null)
    [[ -n "$nodev" ]] && echo "⬢ $nodev"
  fi
}

prompt_time() {
  date +'%H:%M'
}

# Final prompt - order and color can be further enhanced per need
PROMPT='%~ $(prompt_git_info) $(prompt_python_venv) $(prompt_terraform) $(prompt_node) [$(prompt_time)] '

# Optionally, for minimal right-prompt info (enable if desired)
# RPROMPT=''