#!/bin/bash

DOTFILE_PATH="$HOME/.dotfiles"
ZSH_PATH="$DOTFILE_PATH/zsh"
TMUX_PATH="$DOTFILE_PATH/tmux"

OMZ_PATH="$DOTFILE_PATH/lib/ohmyzsh"
TPM_PATH="$DOTFILE_PATH/lib/tpm"

ZSH_CONFIG_FILE="$HOME/.zshrc"
TMUX_CONFIG_FILE="$HOME/.tmux.conf"

ZSH_CUSTOM=$ZSH_PATH/ohmyzsh-custom

echo "Installing dotfiles to $HOME/.dotfiles"

if test -d "$DOTFILE_PATH"; then
	cd $DOTFILE_PATH
	git pull origin master
else
	echo "git clone"
	git clone https://github.com/r1co/dotfiles.git $HOME/.dotfiles
fi

# install ohmyzsh
echo "installing ohmyzsh to $OMZ_PATH"
if test -d "$OMZ_PATH"; then
	echo "update oh-my-zsh"
	env ZSH=$ZSH RUNZSH=no /bin/sh $ZSH/tools/upgrade.sh
else
	ZSH=$OMZ_PATH RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# install tmux plugin manager
echo "install tpm"
echo "installing tpm to $TPM_PATH"
if test -d "$TPM_PATH"; then
	echo "update tpm"
	cd $TPM_PATH
	git pull origin master
else
  git clone https://github.com/tmux-plugins/tpm $TPM_PATH
fi

# install
echo "install zsh-256color"
mkdir -p  $ZSH_CUSTOM/plugins
if test -d "$ZSH_CUSTOM/plugins/zsh-256color"; then
	echo "update zsh-256color"
	cd $ZSH_CUSTOM/plugins
	git pull origin master
else
  cd $ZSH_CUSTOM/plugins && git clone https://github.com/chrissicool/zsh-256color
fi

# install zsh-bd
rm -rf $ZSH_CUSTOM/plugins/bd
mkdir -p $ZSH_CUSTOM/plugins/bd
curl https://raw.githubusercontent.com/Tarrasch/zsh-bd/master/bd.zsh > $ZSH_CUSTOM/plugins/bd/bd.zsh
chmod +x $ZSH_CUSTOM/plugins/bd/bd.zsh

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
