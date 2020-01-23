source "$ZSH_ROOT/flag_handlers.zsh"

defineZshFlag "debug" zsh.flag.handler.debugEnabled
defineZshFlag "tmux-autostart" zsh.flag.handler.autostartTMux
defineZshFlag "dotfiles-update-check" zsh.flag.handler.checkDotfilesUpdate
defineZshFlag "tmux-autostart-new-session" zsh.flag.handler.debugEnabled

defineTmuxFlag "show-external-ip"
defineTmuxFlag "show-cpu-percent"
defineTmuxFlag "show-mem-percent"
