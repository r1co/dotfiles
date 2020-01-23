#/bin/bash
source "$HOME/.dotfiles/tmux/config/common.sh"

cpuInfo() {
  if checkFlag "show-cpu-percent"; then
    echo "$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {printf("%.0f", usage)}')%"
  else
    cat /proc/loadavg | cut -d' ' -f1,2,3 | sed 's/ /:/g'
  fi
}

echo "Ⓟ $(cpuInfo)"

