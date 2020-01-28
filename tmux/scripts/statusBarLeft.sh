#!/bin/bash

TMUX_PATH="$HOME/.dotfiles/tmux"
INFO_SCRIPTS_PATH="$TMUX_PATH/info-scripts"
source "$TMUX_PATH/config/common.sh"

STATUS_INDICATOR="#[$STYLE_STATUS_BAR_INDICATOR]⬟#[#{E:status-right-style}]"
if test -f "/tmp/tmux-inactive"; then
  STATUS_INDICATOR="#[$STYLE_STATUS_BAR_INDICATOR_INACTIVE]⬟#[#{E:status-right-style}]"
fi

echo "$STATUS_INDICATOR #{?window_zoomed_flag,#[fg=$COLOR_FULLSCREEN_INDICATOR]⬟,⬟}#[#{E:status-right-style}] #S:#I.#P"
