#!/bin/bash

source "$HOME/.dotfiles/tmux/config/common.sh"

while [[ "$#" -gt 0 ]]; do
  case $1 in
  -e | --external)
    EXTERNAL=0
    ;;
  esac
  shift
done

ethernetIpLinux() {
  nmcli device status | grep ethernet | cut -d" " -f1 | xargs -i zsh -c "ip route | grep {} | grep scope | cut -d\" \" -f9"
}

externalIp() {
  curl -s ipinfo.io/ip
}

#  ⊤≋
if [ "$EXTERNAL" = 0 ]; then
  echo -e "$USER@$(hostname) | $(externalIp)(e)"
else
  if [ "$(uname)" == "Darwin" ]; then
    # Do something under Mac OS X platform
    echo -e "$USER@$(hostname) | <please implement>(l)"
  elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # Do something under GNU/Linux platform
    echo -e "$USER@$(hostname) | $(ethernetIpLinux)(l)"
  fi
fi
