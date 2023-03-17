ZSH_ROOT="$HOME/.dotfiles/zsh"

source $ZSH_ROOT/vars.zsh

# set completion
fpath=($ZSH_ROOT/completions $fpath)

# load dot util
source $ZSH_ROOT/dot/dot.zsh

DEBUG "Debugging enabled"

# add scripts dir to path
addPathStart $DOTFILES_ROOT/scripts


# disable tmux by default - config.get is used intentionally
$(.dot.config.get plugins.autostartTMux.enabled false)

${DOT_PREFIX}.package.register dot-plugins
${DOT_PREFIX}.package.register config-patch
${DOT_PREFIX}.package.register plugins

# load theme
# source $ZSH_ROOT/themes/dot.zsh-theme
# source $ZSH_ROOT/themes/new-theme.zsh-theme



