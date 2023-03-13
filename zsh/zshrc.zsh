ZSH_ROOT="$HOME/.dotfiles/zsh"

source $ZSH_ROOT/vars.zsh

# load utils
source $ZSH_ROOT/mods/config.zsh
source $ZSH_ROOT/mods/plugins.zsh
source $ZSH_ROOT/mods/flags.zsh
source $ZSH_ROOT/mods/dot.zsh

source $ZSH_ROOT/zsh-utils/utils.zsh
source $ZSH_ROOT/zsh-utils/log.zsh
source $ZSH_ROOT/zsh-utils/aliases.zsh
source $ZSH_ROOT/zsh-utils/colors.zsh


DEBUG "Debugging enabled"

# make sure  scripts storage root exists
mkdir -p $ZSH_STORAGE_ROOT

# add scripts dir to path
export PATH="$DOTFILES_ROOT/scripts:$PATH"


# setup mods
dot.config.setup
dot.plugin.setup
dot.flag.setup
dot.alias.setup

# load theme
source $ZSH_ROOT/themes/dot.zsh-theme
# source $ZSH_ROOT/themes/new-theme.zsh-theme



