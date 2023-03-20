ZSH_ROOT="$HOME/.dotfiles/zsh"

source $ZSH_ROOT/vars.zsh

# set completion
fpath=($ZSH_ROOT/completions $fpath)

# load dot util
source $ZSH_ROOT/dot/dot.zsh

DEBUG "Debugging enabled"

# add scripts dir to path
addPathStart $DOTFILES_ROOT/scripts

# use config.get to set default values
# disable tmux by default -
$(.dot.config.get plugins.autostartTMux.enabled false)

# load module packages
${DOT_PREFIX}.package.register dot-plugins
${DOT_PREFIX}.package.register config-patch
${DOT_PREFIX}.package.register plugins

# set theme
${DOT_PREFIX}.theme.load



