# ==============================
# Modular Zsh Configuration
#
# This .zshrc uses workspace-local modular config via .zshrc.d/
#
# Philosophy:
# - Only active, actually-used configurations are extracted below into .zshrc.d/ fragments.
# - Oh My Zsh, theme, and related setup stay here for clarity and portability.
# - All modular config is in-version-control under this workspace.
#
# Practices:
# - To add config, create a descriptive, numerically-prefixed <nn>-name.zsh file in .zshrc.d/
#   (e.g., 10-boxed-hooks.zsh, 20-alias-ls.zsh, 30-pipx-path.zsh, 40-vscode-integration.zsh).
# - Remove config by deleting its file (with git for tracking).
# - Avoid putting unnecessary or unused boilerplate in modules; keep fragments readable.
# - The symlink at ~/.zshrc.d ensures portability and relocation.
# ==============================

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

setopt NO_NOMATCH
# --- Modular configuration: loading fragments from .zshrc.d/ ---
# Loads all numerically-named, intentionally modularized workspace-local config,
# such as 10-boxed-hooks.zsh, 20-alias-ls.zsh, 30-pipx-path.zsh, 40-vscode-integration.zsh.
# If the .zshrc.d directory doesn't exist, loading is skipped and no error is shown.
# For details, see comments in each .zshrc.d/*.zsh file.
if [ -d "${ZDOTDIR:-$HOME}/.zshrc.d" ]; then
  for f in "${ZDOTDIR:-$HOME}/.zshrc.d/"*.zsh; do
    [ -r "$f" ] && . "$f"
  done
fi
# --- End modular configuration ---

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# Powerlevel10k prompt configuration has been modularized to .zshrc.d/00-oh-my-zsh.zsh
