#!/bin/bash

source "$HOME/.dotfiles/tmux/config/common.sh"



#tmux send-keys M-F12
tmux set -qg status-bg $COLOR_STATUS_BAR_BG
tmux bind -n M-Left select-pane -L
tmux bind -n M-Right select-pane -R
tmux bind -n M-Up select-pane -U
tmux bind -n M-Down select-pane -D
tmux bind -n C-t new-window -a -c "#{pane_current_path}"
tmux set -g @split-statusbar-bindkey '-'
tmux set -g @split-status-hide-bindkey '_'

tmux set -g status-style "$STYLE_STATUS_BAR"
tmux set -g status-right-style "$STYLE_RIGHT"
tmux set -g status-left-style "$STYLE_LEFT"
tmux setw -g window-status-current-style "$STYLE_TAB_ACTIVE"
tmux setw -g window-status-style "$STYLE_TAB"

tmux 	set -qg prefix C-b
rm -f /tmp/tmux-inactive
