function $HANDLER_NAME(){
    VERBOSE "Fix ctrl -> / ctrl <- using bindkeys"
    
    # fix ctrl + -> <-
    bindkey "^[[1;5C" forward-word
    bindkey "^[[1;5D" backward-word
    
    bindkey '^H' backward-kill-word
    bindkey '5~' kill-word
}

function ${HANDLER_NAME}_info(){
    echo "Fixes 'ctrl + <-' / 'ctrl + ->' in terminal using bindkey."
}
