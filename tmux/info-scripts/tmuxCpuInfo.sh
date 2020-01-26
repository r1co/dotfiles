#!/bin/bash
source "$HOME/.dotfiles/tmux/config/common.sh"

while [[ "$#" -gt 0 ]]; do
  case $1 in
  -p | --percentage)
    PERCENTAGE=0
    ;;
  esac
  shift
done

cpuInfoLinux() {
  if [ "$PERCENTAGE" = 0 ]; then
    echo "$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {printf("%.0f", usage)}')%"
  else
    cat /proc/loadavg | cut -d' ' -f1,2,3 | sed 's/ /:/g'
  fi
}


cpuInfoOSX() {
  if [ "$PERCENTAGE" = 0 ]; then
    echo "not supported yet"
  else
    uptime  | grep -o 'load.*' | cut -d":" -f2  | xargs -L1
  fi
}

if [ "$(uname)" == "Darwin" ]; then
    # Do something under Mac OS X platform
    echo "Ⓟ $(cpuInfoOSX)"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # Do something under GNU/Linux platform
    echo "Ⓟ $(cpuInfoLinux)"
fi
