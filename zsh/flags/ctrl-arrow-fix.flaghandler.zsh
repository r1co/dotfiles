function $HANDLER_NAME(){
    VERBOSE "Enabled delete word on 'ctrl + backspace"
    
    # fix ctrl + -> <-
    bindkey "^[[1;5C" forward-word
    bindkey "^[[1;5D" backward-word
}

function ${HANDLER_NAME}_info(){
    echo "Enable delete word on 'ctrl + backspace'"
}
