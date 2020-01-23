#!/bin/bash

source "$HOME/.dotfiles/tmux/config/common.sh"

# set panes clickable
tmux set -g mouse on



# bind reload
tmux bind-key r source-file $HOME/.tmux.conf \; display-message "~/.tmux.conf reloaded"

# change split pane commands
tmux bind '\' split-window -h
tmux bind ] split-window -v
tmux unbind '"'
tmux unbind %
tmux bind-key a new-session -n $HOST

tmux set -g status-right-length 120
tmux set -g status-left-length 120
tmux set -g status-position bottom
tmux set -g status-justify centre


# switch panes using Alt-arrow without prefix
tmux bind -n M-Left select-pane -L
tmux bind -n M-Right select-pane -R
tmux bind -n M-Up select-pane -U
tmux bind -n M-Down select-pane -D

# set theme
# statusbar
tmux set -g status-style "$STYLE_STATUS_BAR"
tmux set -g status-right-style "$STYLE_RIGHT"
tmux set -g status-left-style "$STYLE_LEFT"

tmux set -g status-left "$LEFT_CONTENT"
tmux set -g status-right "$RIGHT_CONTENT"


# active window tab indicator
tmux setw -g window-status-current-style "$STYLE_TAB_ACTIVE"
tmux setw -g window-status-current-format "$TAB_ACTIVE_CONTENT"

# window tab indicator
tmux setw -g window-status-style "$STYLE_TAB"
tmux setw -g window-status-format "$TAB_CONTENT"
#setw -g window-status-bell-style 'fg=colour18 bg=colour1 bold'
tmux set -g visual-bell off

# border color
tmux set -g pane-active-border-style "fg=$COLOR_BORDER_FG bg=$COLOR_BORDER_BG"
tmux set -g pane-border-style "fg=$COLOR_BORDER_FG_INACTIVE bg=$COLOR_BORDER_BG_INACTIVE"

# switch to nested tmux session (shift + up/down)
tmux bind -n M-F11 set -qg status-bg $COLOR_STATUS_BAR_BG_INACTIVE
tmux bind -n M-F12 set -qg status-bg $COLOR_STATUS_BAR_BG

tmux bind -n S-up \
  run -b '$TMUX_SCRIPT_PATH/disable.sh'


tmux bind -n S-down \
  run -b '$TMUX_SCRIPT_PATH/enable.sh'

# set vars
tmux set -g @cpu_low_fg_color "$COLOR_CPU_LOAD_LOW" # foreground color when cpu is low
tmux set -g @cpu_medium_fg_color "$COLOR_CPU_LOAD_MIDDLE" # foreground color when cpu is medium
tmux set -g @cpu_high_fg_color "$COLOR_CPU_LOAD_HIGH" # foreground color when cpu is high

# load tpm
tmux set -g @split-statusbar-mode 'on'                 # [ on | off]
tmux unbind -
tmux set -g @split-statusbar-bindkey '-'
tmux set -g @split-status-hide-bindkey '_'

