# .zshrc.d/vscode-integration.zsh
# Modularized: Integrates VSCode terminal shell-specific enhancements if running in VSCode.
# Originally line 159 from .zshrc.
# Maintained separately to allow straightforward toggling or extension for other workspace-local envs.

[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"