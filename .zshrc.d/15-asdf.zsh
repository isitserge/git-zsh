# asdf version manager integration for modular Zsh config
# Ensures nodejs and python plugins are available and asdf is initialized
# Project-local, under version control

# Add asdf shims to PATH early
export PATH="$HOME/.asdf/shims:$PATH"
if [[ -n $ASDF_DEBUG ]]; then
  echo "[asdf-init] PATH: $PATH"
fi

# Find asdf installation
if [ -d "$HOME/.asdf" ]; then
  ASDF_DIR="$HOME/.asdf"
elif [ -d "/opt/homebrew/opt/asdf" ]; then
  ASDF_DIR="/opt/homebrew/opt/asdf"
elif [ -x "/opt/homebrew/bin/asdf" ]; then
  ASDF_DIR="/opt/homebrew"
else
  ASDF_DIR=""
fi

if [ -n "$ASDF_DIR" ]; then
  # Initialize asdf
  if [ -f "$ASDF_DIR/asdf.sh" ]; then
    . "$ASDF_DIR/asdf.sh"
  elif [ -f "$ASDF_DIR/libexec/asdf.sh" ]; then
    . "$ASDF_DIR/libexec/asdf.sh"
  fi
  # Enable completions if available
  if [ -f "$ASDF_DIR/completions/asdf.bash" ]; then
    fpath=("$ASDF_DIR/completions" $fpath)
    autoload -Uz compinit
    compinit
  fi

  # Helper for plugin presence
  function asdf_has_plugin() {
    asdf plugin list | grep -xq "$1"
  }

  # Ensure nodejs and python plugins are present
  for plugin in nodejs python; do
    if ! asdf_has_plugin "$plugin"; then
      if [[ -n $ASDF_DEBUG ]]; then
        echo "[asdf-init] Installing missing $plugin plugin…"
        asdf plugin add $plugin
      else
        asdf plugin add $plugin &>/dev/null
      fi
    fi
  done

  if [[ -n $ASDF_DEBUG ]]; then
    echo "[asdf-init] asdf initialized ($ASDF_DIR) | nodejs & python plugins ensured"
  fi
else
  echo "[asdf-init] WARNING: asdf not found; installation may be required for version management" 1>&2
fi