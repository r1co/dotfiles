dot_modules=()
enabled_modules=()
# load  enabled config filder
function _dot.load-module() {
    PACKAGE_NAME="$1"
    MODULE_NAME="$2"
    MODULE_DIR="$3"
    # all plugins enabled by default
    enabled=$(${DOT_PREFIX}.config.get "$PACKAGE_NAME.$MODULE_NAME.enabled" true)
    if [ $enabled = "true" ];
    then
        DEBUG "Load '$PACKAGE_NAME.$MODULE_NAME'"
        dot_modules+=( "$PACKAGE_NAME.$MODULE_NAME:$MODULE_DIR" )
        enabled_modules+=( "$PACKAGE_NAME.$MODULE_NAME" )
        
        # echo $MODULE/_DIR
        source $MODULE_DIR
    else
        dot_modules+=( "$PACKAGE_NAME.$MODULE_NAME:$MODULE_DIR" )
        DEBUG "$PACKAGE_NAME.$MODULE_NAME' disabled"
    fi
}

function _dot.load-module-package() {
    PACKAGE_DIR=$1
    PACKAGE_NAME=$(basename $PACKAGE_DIR)
    for file in $(find $PACKAGE_DIR -maxdepth 1 -name "*.zsh"   -type f ); do
        name=$(basename $file)
        name="${name/".zsh"/""}"
        _dot.load-module $PACKAGE_NAME $name $file
    done
    
    for file in $(find $PACKAGE_DIR/ -maxdepth 1 -mindepth 1 -name "*" -type d); do
        name=$(basename $file)
        plugin_path=$file/$name.zsh
        
        if test -f "$plugin_path"; then
            _dot.load-module $PACKAGE_NAME $name $plugin_path
        else
            DEBUG "Folder $name does not contain $name.zsh, skipping"
        fi
    done
}

function _dot.module-enabled() {
    ${DOT_PREFIX}.config.get "$1.enabled" true
}
function _dot.enable-module() {
}
function _dot.disable-module() {
}

# add a folder to configuration
${DOT_PREFIX}.package.register() {
    if [ -n "${1+1}" ]; then
        PACKAGE_DIR="$ZSH_ROOT/$1"
        if [ -d "$PACKAGE_DIR" ]; then
            INFO "Register module $1"
            _dot.load-module-package $PACKAGE_DIR
        else
            printRed "Folder $1 not found!"
        fi
    else
        printRed "Provide folder name"
    fi
}

${DOT_PREFIX}.module.list(){
    local result="Module Path Enabled"
    for module in ${dot_modules[@]}; do
        module_name="$(echo $module | cut -d':' -f1)"
        module_file="$(echo $module | cut -d':' -f2)"
        enabled=$(_dot.module-enabled $module_name)
        result="${result}\n$module_name $module_file $enabled"
        
    done
    echo $result | column -t -s' '
}

${DOT_PREFIX}.module.enable(){
    PACKAGE_NAME=$1
    MODULE_NAME=$2
    
    if [ "$#" -eq 2 ]; then
        enabled=$(${DOT_PREFIX}.config.get "$PACKAGE_NAME.$MODULE_NAME.enabled" true)
        echo "$enabled => true"
        ${DOT_PREFIX}.config.set "$PACKAGE_NAME.$MODULE_NAME.enabled" true
        
        for module in ${dot_modules[@]}; do
            module_name=$(echo $module | cut -d":" -f1)
            module_file=$(echo $module | cut -d":" -f2)
            if [ $module_name = "$PACKAGE_NAME.$MODULE_NAME" ];
            then
                local on_enable_file="${module_file/".zsh"/""}-on-enable.zsh"
                if test -f "$on_enable_file"; then
                    # _dot.load-module $PACKAGE_NAME $name $file
                    DEBUG "Run on-enable file for $PACKAGE_NAME.$MODULE_NAME"
                    source $on_enable_file
                else
                    DEBUG "No on-enable file for $PACKAGE_NAME.$MODULE_NAME"
                fi
            fi
        done
    else
        echo "${DOT_PREFIX}.module.enable <package-name> <module-name>"
    fi
}
${DOT_PREFIX}.module.disable(){
    PACKAGE_NAME=$1
    MODULE_NAME=$2
    
    if [ "$#" -eq 2 ]; then
        enabled=$(${DOT_PREFIX}.config.get "$PACKAGE_NAME.$MODULE_NAME.enabled" false)
        echo "$enabled => false"
        ${DOT_PREFIX}.config.set "$PACKAGE_NAME.$MODULE_NAME.enabled" false
        
        for module in ${dot_modules[@]}; do
            module_name=$(echo $module | cut -d":" -f1)
            module_file=$(echo $module | cut -d":" -f2)
            if [ $module_name = "$PACKAGE_NAME.$MODULE_NAME" ];
            then
                local on_disable_file="${module_file/".zsh"/""}-on-disable.zsh"
                if test -f "$on_disable_file"; then
                    # _dot.load-module $PACKAGE_NAME $name $file
                    DEBUG "Run on-disable file for $PACKAGE_NAME.$MODULE_NAME"
                    source $on_disable_file
                else
                    DEBUG "No on-disable file for $PACKAGE_NAME.$MODULE_NAME"
                fi
            fi
        done
    else
        echo "${DOT_PREFIX}.module.disable <package-name> <module-name>"
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