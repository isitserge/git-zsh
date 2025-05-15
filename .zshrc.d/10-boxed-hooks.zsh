# .zshrc.d/boxed-hooks.zsh
# Modularized: Visual boxed command line hooks for encapsulating command output.
# Originally lines 120-147 from .zshrc (see project .zshrc for context).
# This sets up colored box headers/footers around executed shell commands.

# Colors for boxes
BOX_COLOR_TOP="%F{blue}"
BOX_COLOR_BOTTOM_SUCCESS="%F{green}"
BOX_COLOR_BOTTOM_ERROR="%F{red}"
BOX_COLOR_RESET="%f"

# Hook functions (preexec/precmd)
_roo_box_preexec() {
  print -P "${BOX_COLOR_TOP}┌──[Running: ${1}]${BOX_COLOR_RESET}"
}
_roo_box_precmd() {
  local ec=$?
  if [[ $ec -eq 0 ]]; then
    print -P "${BOX_COLOR_BOTTOM_SUCCESS}└──[Exit $ec]${BOX_COLOR_RESET}"
  else
    print -P "${BOX_COLOR_BOTTOM_ERROR}└──[Exit $ec]${BOX_COLOR_RESET}"
  fi
}

# Delay hook activation until first prompt
autoload -Uz add-zsh-hook
_zsh_lazy_hook_enable() {
  add-zsh-hook precmd _roo_box_precmd
  add-zsh-hook preexec _roo_box_preexec
  add-zsh-hook -d precmd _zsh_lazy_hook_enable
}
add-zsh-hook precmd _zsh_lazy_hook_enable