function $HANDLER_NAME(){
    # check if dotfiles dirty
    if [[ $(cd ~/.dotfiles && git diff --stat) != '' ]]; then
        printRed "!!! Please commit dotfile changes !!!"
    fi
}

function ${HANDLER_NAME}_info(){
    echo "Checks if dotfiles repo is dirty"
}
