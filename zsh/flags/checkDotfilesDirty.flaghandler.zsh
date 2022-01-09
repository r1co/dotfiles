function $HANDLER_NAME(){
    # check if dotfiles dirty
	if [[ $(cd ~/.dotfiles && git diff --stat) != '' ]]; then
		printRed "!!! Please commit dotfile changes !!!"
	fi
}