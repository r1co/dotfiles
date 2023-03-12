#!/bin/bash

DOTFILE_PATH="$HOME/.dotfiles"
ZSH_PATH="$DOTFILE_PATH/zsh"
TMUX_PATH="$DOTFILE_PATH/tmux"

ZSH_CONFIG_FILE="$HOME/.zshrc"
TMUX_CONFIG_FILE="$HOME/.tmux.conf"


echo "Installing dotfiles to $HOME/.dotfiles"

if test -d "$DOTFILE_PATH"; then
    cd $DOTFILE_PATH
    git pull origin master
else
    echo "git clone"
    git clone https://github.com/r1co/dotfiles.git $HOME/.dotfiles
fi


echo "creating symlinks"
if test -f "$ZSH_CONFIG_FILE"; then
    echo "$ZSH_CONFIG_FILE exists"
    #	mv $ZSH_CONFIG_FILE $ZSH_CONFIG_FILE.pre-install-dotfiles
else
    ln -s $ZSH_PATH/zshrc.zsh $ZSH_CONFIG_FILE
fi

if test -f "$TMUX_CONFIG_FILE"; then
    echo "$TMUX_CONFIG_FILE exists"
    # mv $TMUX_CONFIG_FILE $TMUX_CONFIG_FILE.pre-install-dotfiles
else
    ln -s $TMUX_PATH/tmux.conf $TMUX_CONFIG_FILE
fi


echo "done"
