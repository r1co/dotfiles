# source "$ZSH_ROOT/flag_handlers.zsh"

# defineZshFlag "debug" zsh.flag.handler.debugEnabled
# defineZshFlag "tmux-autostart" zsh.flag.handler.autostartTMux
# defineZshFlag "dotfiles-update-check" zsh.flag.handler.checkDotfilesUpdate
# defineZshFlag "tmux-autostart-new-session" zsh.flag.handler.debugEnabled

# defineTmuxFlag "show-external-ip"
# defineTmuxFlag "show-cpu-percent"
# defineTmuxFlag "show-mem-percent"

for file in $(find $ZSH_FLAG_CONFIG_ROOT -name "*$ZSH_FLAG_HANDLER_EXT" -type f); do 
    # echo "$file"; 
    # echo "name $name"
    name=$(basename $file)
    name="${name/"$ZSH_FLAG_HANDLER_EXT"/""}"
    HANDLER_NAME="zsh.flag.handler.$name"
    source $file   
    defineZshFlag "$name" $HANDLER_NAME 

done
