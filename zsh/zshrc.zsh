ZSH_ROOT="$HOME/.dotfiles/zsh"

source $ZSH_ROOT/vars.zsh

# load dot util
source $ZSH_ROOT/dot/dot.zsh

DEBUG "Debugging enabled"

# make sure  scripts storage root exists
mkdir -p $ZSH_STORAGE_ROOT

# add scripts dir to path
export PATH="$DOTFILES_ROOT/scripts:$PATH"

# setup mods
${DOT_PREFIX}.config.setup
${DOT_PREFIX}.module.register dot-plugins
${DOT_PREFIX}.module.register plugins
${DOT_PREFIX}.module.register aliases
# ${DOT_PREFIX}.config.register zsh-utils
# dot.plugin.setup
# dot.flag.setup
# dot.alias.setup

# load theme
source $ZSH_ROOT/themes/dot.zsh-theme
# source $ZSH_ROOT/themes/new-theme.zsh-theme



