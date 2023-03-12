ZSH_ROOT="$HOME/.dotfiles/zsh"

# load utils
source $ZSH_ROOT/zsh-utils/utils.zsh
source $ZSH_ROOT/zsh-utils/debug.zsh
source $ZSH_ROOT/zsh-utils/flags.zsh
source $ZSH_ROOT/zsh-utils/aliases.zsh
source $ZSH_ROOT/zsh-utils/colors.zsh

source $ZSH_ROOT/vars.zsh

DEBUG "Debugging enabled"

# make sure  scripts storage root exists
mkdir -p $ZSH_STORAGE_ROOT

# add scripts dir to path
export PATH="$DOTFILES_ROOT/scripts:$PATH"

# load theme
source $ZSH_ROOT/themes/dot.zsh-theme

# load plugins
source $ZSH_ROOT/plugins/bd/bd.zsh
source $ZSH_ROOT/plugins/autosuggestions/zsh-autosuggestions.zsh



# make sure flag root exists
mkdir -p $FLAG_ROOT
# parse flag handlers. each handler is added as flag option.
for file in $(find $ZSH_FLAG_CONFIG_ROOT -name "*$ZSH_FLAG_HANDLER_EXT" -type f); do
    # echo "$file";
    # echo "name $name"
    name=$(basename $file)
    name="${name/"$ZSH_FLAG_HANDLER_EXT"/""}"
    HANDLER_NAME="zsh._flag.handler.$name"
    source $file
    defineZshFlag "$name" $HANDLER_NAME
    
done

# load all aliases in folder
for file in $(find $ZSH_ALIASES_CONFIG_ROOT -name "*.zsh" -type f); do
    DEBUG "Parse aliases in $file"
    source $file
done



