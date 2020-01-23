#!/bin/bash

source "$HOME/.dotfiles/tmux/config/common.sh"

ethernetIp() {
  nmcli device status | grep ethernet | cut -d" " -f1 | xargs -i zsh -c "ip route | grep {} | grep scope | cut -d\" \" -f9"
}

externalIp() {
  curl -s ipinfo.io/ip
}

#  ⊤≋
if checkFlag "show-external-ip"; then
  echo -e "$USER@$(hostname) | $(externalIp)(e)"
else
  echo -e "$USER@$(hostname) | $(ethernetIp)(l)"
fi
