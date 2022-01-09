function $HANDLER_NAME(){
	DEBUG "Check if check dotfiles update should run"
	COUNTER_FILE="$ZSH_SCRIPTS_STORAGE_ROOT/update-check-counter"
	
	# create counter if missing 
	if [ ! -f "$COUNTER_FILE" ]; then
    	echo "0" > $COUNTER_FILE
	fi

	CHECK_EVERT_N_STARTUPS=10
	COUNTER_VALUE=$(cat $COUNTER_FILE)

	DEBUG "Startups since last update: $COUNTER_VALUE"

	if [ "$COUNTER_VALUE" -le "$CHECK_EVERT_N_STARTUPS" ]; then
		DEBUG "Check update every $CHECK_EVERT_N_STARTUPS startups, skip"
		COUNTER_VALUE=$((COUNTER_VALUE + 1))
		echo $COUNTER_VALUE > $COUNTER_FILE
	else
		# check if there are dotfile updates available (slows down zsh startup)
		printBlue "Check if dotfiles update available"
		FETCH=$(cd ~/.dotfiles/ && git fetch --quiet)
		HEADHASH=$(cd ~/.dotfiles/ && git rev-parse HEAD)
		UPSTREAMHASH=$(cd ~/.dotfiles/ && git rev-parse master@{upstream})
		if [ "$HEADHASH" != "$UPSTREAMHASH" ]
		then
			printYellow '!!! Please pull dotfile updates !!!'
		else
			printBlue "No updates available"
		fi
		echo "0" > $COUNTER_FILE
	fi
	
}
