#!/bin/bash

TMUX_PATH="$HOME/.dotfiles/tmux"
INFO_SCRIPTS_PATH="$TMUX_PATH/info-scripts"
source "$TMUX_PATH/config/common.sh"

enabledState() {
  UPTIME=$($INFO_SCRIPTS_PATH/tmuxUptimeInfo.sh)
  DATA_TIME="$(date +"%d.%m %H:%M")"

  if checkFlag "show-mem-percent"; then
    MEM=$($INFO_SCRIPTS_PATH/tmuxMemInfo.sh -p)
  else
    MEM=$($INFO_SCRIPTS_PATH/tmuxMemInfo.sh)
  fi

  if checkFlag "show-cpu-percent"; then
    CPU=$($INFO_SCRIPTS_PATH/tmuxCpuInfo.sh -p)
  else
    CPU=$($INFO_SCRIPTS_PATH/tmuxCpuInfo.sh)
  fi

  if checkFlag "show-external-ip"; then
    NETWORK=$($INFO_SCRIPTS_PATH/tmuxNetworkInfo.sh -e)
  else
    NETWORK=$($INFO_SCRIPTS_PATH/tmuxNetworkInfo.sh)
  fi

  echo "$NETWORK$DEFAULT_SEPERATOR$MEM$DEFAULT_SEPERATOR$CPU$DEFAULT_SEPERATOR$DATA_TIME$UPTIME"
}

disabledState() {
  echo "$(enabledState)"
}

ifTmuxEnabled enabledState disabledState
