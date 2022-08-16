ZSH_ROOT="$HOME/.dotfiles/zsh"
source $ZSH_ROOT/vars.zsh
source $ZSH_ROOT/functions.zsh

DEBUG "Debugging enabled"

# create scripts storage root 
mkdir -p $ZSH_SCRIPTS_STORAGE_ROOT

# set zsh root
export ZSH="$OHMYZSH_ROOT"

# Set theme 
ZSH_CUSTOM=$ZSH_ROOT/ohmyzsh-custom

# See custom/theme/my-theme.zsh-theme
if [[ -z "$ZSH_THEME" ]]; then
  if [[ $EUID -ne 0 ]]; then
    ZSH_THEME="dot"
  else
    ZSH_THEME="dot-root"
  fi
fi

# select plugins
plugins=(zsh-256color git docker aliases history gitignore)

# source ohmyzsh
source $ZSH/oh-my-zsh.sh

# load bd plugin
. $ZSH_ROOT/plugins/bd/bd.zsh

# source flags
source $ZSH_ROOT/flags.zsh

# source config
source $ZSH_ROOT/aliases.zsh


[[ $COLORTERM = *(24bit|truecolor)* ]] || zmodload zsh/nearcolor

# load host config
HOST_CONFIG="$HOST_CONFIG_ROOT/$(hostname).zsh"
if test -f "$HOST_CONFIG"; then
	DEBUG "source host config $HOST_CONFIG";
	source $HOST_CONFIG
else
	DEBUG "host config not found ($HOST_CONFIG)";
fi

# do not edit this file with host specfic config! 
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"


# Load Angular CLI autocompletion.
source <(ng completion script)
