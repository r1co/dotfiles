function $HANDLER_NAME(){
    VERBOSE "Check if check dotfiles update should run"
    # COUNTER_FILE="$ZSH_STORAGE_ROOT/update-check-counter"
    CHECK_EVERY_N_STARTUPS=$(.dot.config.get check_dotfiles_remote_every_n 10)
    
    # # create counter if missing
    # if [ ! -f "$COUNTER_FILE" ]; then
    #     echo "0" > $COUNTER_FILE
    # fi
    
    COUNTER_VALUE=$(.dot.config.get check_dotfiles_counter 0)
    
    VERBOSE "Startups since last update: $COUNTER_VALUE"
    
    if [ "$COUNTER_VALUE" -le "$CHECK_EVERY_N_STARTUPS" ]; then
        VERBOSE "Check update every $CHECK_EVERY_N_STARTUPS startups, skip"
        COUNTER_VALUE=$((COUNTER_VALUE + 1))
        # echo $COUNTER_VALUE > $COUNTER_FILE
        .dot.config.set check_dotfiles_counter $COUNTER_VALUE
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
        # echo "0" > $COUNTER_FILE
        .dot.config.set check_dotfiles_counter 0
        
    fi
}

function ${HANDLER_NAME}_info(){
    echo "Checks every n ($CHECK_EVERY_N_STARTUPS) starts if dotfiles can be updated. ($COUNTER_VALUE/$CHECK_EVERY_N_STARTUPS)"
}
