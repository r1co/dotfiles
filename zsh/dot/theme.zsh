
function ${DOT_PREFIX}.theme.load(){
    THEME=$(.dot.config.get zsh.theme "dot")
    
    THEME_PATH="$THEME_ROOT/$THEME.zsh-theme"
    
    if test -f "$THEME_PATH"; then
        source $THEME_PATH
    else
        printRed "$THEME_PATH not found!"
    fi
}