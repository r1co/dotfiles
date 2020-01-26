#!/bin/bash

TMUX_PATH="$HOME/.dotfiles/tmux"
INFO_SCRIPTS_PATH="$TMUX_PATH/info-scripts"
source "$TMUX_PATH/config/common.sh"

enabledState(){
  echo " #S:#I.#P#{?window_zoomed_flag,#[fg=$COLOR_FULLSCREEN_INDICATOR]##,##}#[#{E:status-right-style}]>"
}

disabledState(){
  echo "$(enabledState) "
}

ifTmuxEnabled enabledState disabledState
