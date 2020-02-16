ZSH_ROOT="$HOME/.dotfiles/zsh"
source $ZSH_ROOT/vars.zsh
source $ZSH_ROOT/functions.zsh

DEBUG "Debugging enabled"

# set zsh root
export ZSH="$OHMYZSH_ROOT"




# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$ZSH_ROOT/ohmyzsh-custom

# See custom/theme/my-theme.zsh-theme
if [[ $EUID -ne 0 ]]; then
   ZSH_THEME="dot"
else
  ZSH_THEME="dot-root"
fi

# select plugins
plugins=(zsh-256color git docker)

# load bd plugin
. $ZSH_CUSTOM/plugins/bd/bd.zsh

# load host config
HOST_CONFIG="$HOST_CONFIG_ROOT/$(hostname).zsh"
if test -f "$HOST_CONFIG"; then
	DEBUG "source host config $HOST_CONFIG";
	source $HOST_CONFIG
else
	DEBUG "host config not found ($HOST_CONFIG)";
fi

# source ohmyzsh
source $ZSH/oh-my-zsh.sh

# source config
source $ALIASES_FILE

# source flags
source $FLAGS_FILE

[[ $COLORTERM = *(24bit|truecolor)* ]] || zmodload zsh/nearcolor

