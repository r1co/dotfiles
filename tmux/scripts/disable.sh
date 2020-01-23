#!/bin/bash

source "$HOME/.dotfiles/tmux/config/common.sh"


#tmux send-keys M?-F12
tmux set -qg status-bg $COLOR_STATUS_BAR_BG_INACTIVE
tmux unbind -n C-t
tmux unbind -n M-Left
tmux unbind -n M-Right
tmux unbind -n M-Up
tmux unbind -n M-Down

tmux set -g status-style "$STYLE_STATUS_BAR_INACTIVE"
tmux set -g status-right-style "$STYLE_RIGHT_INACTIVE"
tmux set -g status-left-style "$STYLE_LEFT_INACTIVE"
tmux setw -g window-status-current-style "$STYLE_TAB_ACTIVE_INACTIVE"
tmux setw -g window-status-style "$STYLE_TAB_INACTIVE"

#tmux unbind -n -
#tmux unbind -n _

tmux set -qg prefix C-a
tmux display-message "disabled"

touch /tmp/tmux-inactive
