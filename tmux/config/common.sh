#!/bin/bash

source "$HOME/.dotfiles/tmux/config/colors.sh"
source "$HOME/.dotfiles/tmux/config/styles.sh"
source "$HOME/.dotfiles/tmux/config/helper.sh"
# Contents ----------------
DEFAULT_SEPERATOR=' | '
LEFT_CONTENT="#($TMUX_SCRIPT_PATH/statusBarLeft.sh)"
RIGHT_CONTENT="#($TMUX_SCRIPT_PATH/statusBarRight.sh)"
TAB_ACTIVE_CONTENT=" #I:#W "
TAB_CONTENT=" #I:#W "
