ZSH_ROOT="$HOME/.dotfiles/zsh"
source $ZSH_ROOT/vars.zsh
source $ZSH_ROOT/functions.zsh

DEBUG "Debugging enabled"

# create scripts storage root
mkdir -p $ZSH_SCRIPTS_STORAGE_ROOT

# configure scripts
export PATH="$DOTFILES_ROOT/scripts:$PATH"

# load theme
source $ZSH_ROOT/themes/dot.zsh-theme

# load bd plugin
source $ZSH_ROOT/plugins/bd/bd.zsh

# source flags
source $ZSH_ROOT/flags.zsh

# source config
source $ZSH_ROOT/aliases.zsh

# colors
[[ $COLORTERM = *(24bit|truecolor)* ]] || zmodload zsh/nearcolor

