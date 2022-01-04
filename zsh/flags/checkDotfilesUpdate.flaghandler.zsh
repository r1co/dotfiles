function $HANDLER_NAME(){
    # # check if dotfiles dirty
	if [[ $(cd ~/.dotfiles && git diff --stat) != '' ]]; then
	  echo '!!! Please commit dotfile changes !!!'
	fi

	# check if there are dotfile updates available (slows down zsh startup)
	FETCH=$(cd ~/.dotfiles/ && git fetch --quiet)
	HEADHASH=$(cd ~/.dotfiles/ && git rev-parse HEAD)
	UPSTREAMHASH=$(cd ~/.dotfiles/ && git rev-parse master@{upstream})
	if [ "$HEADHASH" != "$UPSTREAMHASH" ]
	 then
	    echo '!!! Please push/pull dotfile changes !!!'
	fi
}