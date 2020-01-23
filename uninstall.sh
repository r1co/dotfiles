#!/bin/bash

echo "Removing dotfiles to $HOME/.dotfiles"

# rm -r $HOME/.dotfiles 

rm $HOME/.zshrc
rm $HOME/.tmux.conf

echo "done"