#!/bin/bash

uptimeInfoLinux(){
  UPTIME_HOURS=$( echo $(awk '{print $1}' /proc/uptime) / 3600 | bc)
  UPTIME_MIN=$( echo $(awk '{print $1}' /proc/uptime) / 60  | bc)
  UPTIME_MIN=$(echo "$UPTIME_MIN%60" | bc)

  if [ $UPTIME_MIN -lt 10 ]; then
    UPTIME_MIN="0$UPTIME_MIN"
  fi
  echo $UPTIME_HOURS:$UPTIME_MIN
}

uptimeInfoOSX() {
  echo ""
}

if [ "$(uname)" == "Darwin" ]; then
    # Do something under Mac OS X platform
    uptimeInfoOSX
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # Do something under GNU/Linux platform
    uptimeInfoLinux
fi
