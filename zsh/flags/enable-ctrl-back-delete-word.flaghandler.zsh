function $HANDLER_NAME(){
    VERBOSE "Enabled delete word on 'ctrl + backspace"
    
    bindkey '^H' backward-kill-word
    bindkey '5~' kill-word
}

function ${HANDLER_NAME}_info(){
    echo "Enable delete word on 'ctrl + backspace'"
}
