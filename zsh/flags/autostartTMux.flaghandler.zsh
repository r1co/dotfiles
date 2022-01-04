function $HANDLER_NAME(){
     # return (disable) if flag is set to true
    if [ ! -z "$DOTFILES_DISABLE_TMUX" ]; then
      if [ "$DOTFILES_DISABLE_TMUX" -eq 0 ]; then
        echo "tmux disabled by environment flag"
        return
      fi
    fi

    if checkFlag "tmux-autostart-new-session" $ZSH_FLAG_EXT; then
      [[ $- != *i* ]] && return
      [[ -z "$TMUX" ]] && exec tmux
    else
      [[ $- != *i* ]] && return
      [[ -z "$TMUX" ]] && exec tmux attach
    fi
}