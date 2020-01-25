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

memInfoLinux() {
  FREE_OPTION="--giga"
  OUPUT=$(free $FREE_OPTION | awk 'NR==2{printf "%s/%sGb", $3,$2}')
  TOTAL="$(free $FREE_OPTION | awk 'NR==2{printf "%s", $2 }')"
  USED="$(free $FREE_OPTION | awk 'NR==2{printf "%s", $3 }')"
  FREE="$(free $FREE_OPTION | awk 'NR==2{printf "%s", $4 }')"

  HIGH_MIN=85
  MIDDLE_MIN=75

  MEM_FREE_PERCENT=$((($USED * 100) / $TOTAL))

  #A=$((100-$A))
  if [ "$PERCENTAGE" = 0 ]; then
    OUPUT="$MEM_FREE_PERCENT%"
  fi

  OUPUT="Ⓜ $OUPUT"

  if [ "$MEM_FREE_PERCENT" -gt "$HIGH_MIN" ]; then
    echo "$OUPUT#[#{E:status-right-style}]"
    # #[fg=colour196]
  elif [ "$MEM_FREE_PERCENT" -gt "$MIDDLE_MIN" ]; then
    echo "$OUPUT#[#{E:status-right-style}]"
    # #[fg=colour208]
  else
    echo "$OUPUT#[#{E:status-right-style}]"
    # #[fg=colour064]
  fi
}

memInfoOSX() {
  echo "not supported yet"
}

if [ "$(uname)" == "Darwin" ]; then
    # Do something under Mac OS X platform
    memInfoOSX
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # Do something under GNU/Linux platform
    memInfoLinux
fi
