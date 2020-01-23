#!/bin/bash

ifTmuxEnabled (){
  if test -f "/tmp/tmux-inactive"; then
    $2
  else
    $1
  fi
}

checkFlag () {
  FLAG="$HOME/.dotfiles/flags/$1.tmux.flag"
  if test -f "$FLAG"; then
    return 0;
  fi
  return 1;
}
