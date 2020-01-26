#!/bin/bash

function zsh.flag.handler.autostartTMux () {
    # return (disable) if flag is set to true
    if [ ! -z "$DOTFILES_DISABLE_TMUX" ]; then
      if [ "$DOTFILES_DISABLE_TMUX" -eq 0 ]; then
        echo "tmux disabled by environment flag"
        return
      fi
    fi

    if checkFlag "tmux-autostart-new-session" $ZSH_FLAG_EXT; then
      [[ $- != *i* ]] && return
      [[ -z "$TMUX" ]] && exec tmux
    else
      [[ $- != *i* ]] && return
      [[ -z "$TMUX" ]] && exec tmux attach
    fi

}

function zsh.flag.handler.checkDotfilesUpdate () {
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

function zsh.flag.handler.debugEnabled () {
	# no nothing
}
