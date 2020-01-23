#!/bin/bash

UPTIME_HOURS=$( echo $(awk '{print $1}' /proc/uptime) / 3600 | bc)
UPTIME_MIN=$( echo $(awk '{print $1}' /proc/uptime) / 60  | bc)
UPTIME_MIN=$(echo "$UPTIME_MIN%60" | bc)
echo $UPTIME_HOURS:$UPTIME_MIN
