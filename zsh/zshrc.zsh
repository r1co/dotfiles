ZSH_ROOT="$HOME/.dotfiles/zsh"
source $ZSH_ROOT/vars.zsh
source $ZSH_ROOT/functions.zsh

DEBUG "Debugging enabled"

# set zsh root
export ZSH="$OHMYZSH_ROOT"

# Set theme 
ZSH_CUSTOM=$ZSH_ROOT/ohmyzsh-custom

# See custom/theme/my-theme.zsh-theme
if [[ $EUID -ne 0 ]]; then
   ZSH_THEME="dot"
else
  ZSH_THEME="dot-root"
fi

# select plugins
plugins=(zsh-256color git docker)

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

# load bd plugin
. $ZSH_ROOT/plugins/bd/bd.zsh

# source config
source $ALIASES_FILE

# source flags
source $FLAGS_FILE

[[ $COLORTERM = *(24bit|truecolor)* ]] || zmodload zsh/nearcolor



# nvm 
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# global yarn 
export PATH="$PATH:`yarn global bin`"

# platformio
export PATH="$PATH:/home/r1co/.platformio/penv/bin"

# pip 
export PATH="$PATH:/home/r1co/.local/bin"

# go 
export PATH="$PATH:/home/r1co/go/bin"
