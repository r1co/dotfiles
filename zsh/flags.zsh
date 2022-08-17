# parse flag handlers. each handler is added as flag option. 
for file in $(find $ZSH_FLAG_CONFIG_ROOT -name "*$ZSH_FLAG_HANDLER_EXT" -type f); do 
    # echo "$file"; 
    # echo "name $name"
    name=$(basename $file)
    name="${name/"$ZSH_FLAG_HANDLER_EXT"/""}"
    HANDLER_NAME="zsh.flag.handler.$name"
    source $file   
    defineZshFlag "$name" $HANDLER_NAME 

done
