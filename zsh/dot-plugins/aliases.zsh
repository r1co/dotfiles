
function common_alias() {
    name=$1
    command=$2
    
    DEBUG_ALIASES "Add common alias $name"
    alias $name=$command
}

function linux_alias() {
    name=$1
    command=$2
    
    if [[ "$(isLinux)" == true ]]; then
        DEBUG_ALIASES "Add linux alias $name"
        alias $name=$command
    else
        DEBUG_ALIASES "Ignore alias $name for platform $(getPlatform)"
    fi
}

function osx_alias() {
    name=$1
    command=$2
    
    if [[ "$(isDarwin)" == true ]]; then
        DEBUG_ALIASES "Add osx alias $name"
        alias $name=$command
    else
        DEBUG_ALIASES "Ignore alias $name for platform $(getPlatform)"
    fi
}

function ${DOT_PREFIX}.alias.list(){
    # ls  $ZSH_ALIASES_CONFIG_ROOT | xargs -I{} echo "├─ {}"
    for file in $(find $ZSH_ALIASES_CONFIG_ROOT -name "*.zsh" -type f); do
        echo "├─ $(basename $file)"
        cat $file | grep -e "common_alias" | cut -d" " -f2 | xargs -I{} echo "|  ├─ {} (common)"
        cat $file | grep -e "linux_alias" | cut -d" " -f2 | xargs -I{} echo "|  ├─ {} (linux)"
        cat $file | grep -e "osx_alias" | cut -d" " -f2 | xargs -I{} echo "|  ├─ {} (osx)"
        cat $file | grep -e "function "  |xargs -L1 | cut -d" " -f2 | xargs  -I{}  echo "|  ├─ {} (function)"
    done
    
    #
}

# function dot.alias.setup(){
#     # alias  helper functions

#     # load all aliases in folder
#     for file in $(find $ZSH_ALIASES_CONFIG_ROOT -name "*.zsh" -type f); do
#         DEBUG "Parse aliases in $file"
#         source $file
#     done
# }