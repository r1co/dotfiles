#!/bin/bash

TMUX_PATH="$HOME/.dotfiles/tmux"
INFO_SCRIPTS_PATH="$TMUX_PATH/info-scripts"
source "$TMUX_PATH/config/common.sh"

enabledState(){
  UPTIME=$($INFO_SCRIPTS_PATH/tmuxUptimeInfo.sh)
  MEM=$($INFO_SCRIPTS_PATH/tmuxMemInfo.sh)
  CPU=$($INFO_SCRIPTS_PATH/tmuxCpuInfo.sh)
  NETWORK=$($INFO_SCRIPTS_PATH/tmuxNetworkInfo.sh)
  DATA_TIME="$(date +"%d.%m %H:%M")"
  echo "$NETWORK$DEFAULT_SEPERATOR$MEM$DEFAULT_SEPERATOR$CPU$DEFAULT_SEPERATOR$DATA_TIME ($UPTIME)"
}

disabledState(){
  echo "$(enabledState)"
}

ifTmuxEnabled enabledState disabledState
