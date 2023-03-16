# load  enabled config filder
function _dot.load-module() {
    MODULE_DIR=$1
    MODULE_NAME=$(basename $MODULE_DIR)
    for file in $(find $MODULE_DIR -maxdepth 1 -name "*.zsh"   -type f ); do
        name=$(basename $file)
        name="${name/".zsh"/""}"
        # all plugins enabled by default
        enabled=$(${DOT_PREFIX}.config.get "$MODULE_NAME.$name.enabled" true)
        if [ $enabled = "true" ];
        then
            DEBUG "Load '$MODULE_NAME.$name'"
            source $file
        else
            DEBUG "$MODULE_NAME.$name' disabled"
        fi
    done
    
    for file in $(find $MODULE_DIR/ -maxdepth 1 -mindepth 1 -name "*" -type d); do
        name=$(basename $file)
        plugin_path=$file/$name.zsh
        
        if test -f "$plugin_path"; then
            enabled=$(${DOT_PREFIX}.config.get "$MODULE_NAME.$name.enabled" true)
            if [ $enabled = "true" ];
            then
                DEBUG "Load '$MODULE_NAME.$name'"
                source $file
            else
                DEBUG "$MODULE_NAME.$name' disabled"
            fi
        else
            DEBUG "Folder $name does not contain $name.zsh, skipping"
        fi
    done
}


# add a folder to configuration
${DOT_PREFIX}.module.register() {
    if [ -n "${1+1}" ]; then
        MODULE_DIR="$ZSH_ROOT/$1"
        if [ -d "$MODULE_DIR" ]; then
            INFO "Register module $1"
            _dot.load-module $MODULE_DIR
        else
            printRed "Folder $1 not found!"
        fi
    else
        printRed "Provide folder name"
    fi
}

# function dot.plugin.enable(){
#     PLUGIN_FILE="$ZSH_PLUGIN_ROOT/$1.zsh"
#     if test -f "$PLUGIN_FILE"; then
#         dot.config.set "plugin.$1.enabled" true
#         INFO "Plugin '$1' enabled"
#     else
#         INFO "Plugin '$1' not found!"
#     fi
# }

# function dot.plugin.disable(){
#     PLUGIN_FILE="$ZSH_PLUGIN_ROOT/$1.zsh"
#     if test ! -f "$PLUGIN_FILE"; then
#         INFO "Plugin '$1' not found!"
#     fi

#     dot.config.set "plugin.$1.enabled" false
#     INFO "Plugin '$1' disabled"
# }

# # load all enabled plugins
# function dot.plugin.loadEnabled() {
#     for file in $(find $ZSH_PLUGIN_ROOT -maxdepth 1 -name "*.zsh"   -type f ); do
#         name=$(basename $file)
#         name="${name/".zsh"/""}"
#         # all plugins enabled by default
#         enabled=$(dot.config.get "plugin.$name.enabled" true)
#         if [ $enabled = "true" ];
#         then
#             DEBUG "Load enabled plugin '$name'"
#             source $file
#         else
#             DEBUG "Plugin '$name' disabled"
#         fi
#     done

#     for file in $(find $ZSH_PLUGIN_ROOT/ -maxdepth 1 -mindepth 1 -name "*" -type d); do
#         name=$(basename $file)
#         plugin_path=$file/$name.zsh

#         if test -f "$plugin_path"; then
#             enabled=$(dot.config.get "plugin.$name.enabled" true)
#             if [ $enabled = "true" ];
#             then
#                 DEBUG "Load enabled plugin '$name'"
#                 source $file
#             else
#                 DEBUG "Plugin '$name' disabled"
#             fi
#         else
#             DEBUG "Folder $name does not contain $name.zsh, skipping"
#         fi
#     done
# }