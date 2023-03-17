if [ -z ${ZSH_ALIASES_CONFIG_ROOT+x} ];
then
    ZSH_ALIASES_CONFIG_ROOT="$ZSH_ROOT/aliases"
fi

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
    local table_spacer="!"
    # ls  $ZSH_ALIASES_CONFIG_ROOT | xargs -I{} echo "├─ {}"
    local function parseAlias(){
        fileName=$(basename $1)
        fileName="${fileName/".zsh"/""}"
        enabled=$(${DOT_PREFIX}.config.get "aliases.$fileName.enabled" true)
        
        result=""
        cat $1  | sed -E 's/\\n/#NEW_LINE#/gm' | grep -e "$2" | cut -d" " -f2- | while read line
        do
            # echo -e "line $line"
            alias_name=$(echo $line | cut -d" " -f1)
            alias_arg=$(echo $line | cut -d" " -f2- | sed -E 's/\\n/|/gm' )
            # echo $alias_arg
            result="${result}\n$2$table_spacer$fileName$table_spacer$alias_name$table_spacer$enabled$table_spacer${alias_arg}"
        done
        echo $result
    }
    local function parseFnAlias(){
        fileName=$(basename $1)
        fileName="${fileName/".zsh"/""}"
        enabled=$(${DOT_PREFIX}.config.get "aliases.$fileName.enabled" true)
        
        result=""
        cat $1 | grep -e "^function" | cut -d" " -f2 | cut -d"(" -f1 | while read line
        do
            result="${result}\n$2$table_spacer$fileName$table_spacer$line$table_spacer$enabled"
        done
        echo $result
    }
    
    result=""
    for file in $(find $ZSH_ALIASES_CONFIG_ROOT -name "*.zsh" -type f); do
        fileName=$(basename $file)
        fileName="${fileName/".zsh"/""}"
        
        result="${result}\n$(parseAlias $file common_alias)"
        result="${result}\n$(parseAlias $file linux_alias)"
        result="${result}\n$(parseAlias $file osx_alias)"
        result="${result}\n$(parseFnAlias $file function)"
        # cat $file | grep -e "common_alias" | cut -d" " -f2 | while read line
        # do
        #     result="${result}\ncommon_alias $fileName $line"
        # done
        # cat $file | grep -e "linux_alias" | cut -d" " -f2| while read line
        # do
        #     result="${result}\nlinux_alias $line"
        # done
        # cat $file | grep -e "osx_alias" | cut -d" " -f2 | while read line
        # do
        #     result="${result}\nosx_alias $line"
        # done
        # cat $file | grep -e "linux_alias" | cut -d" " -f2 | xargs -I{} echo "|  ├─ {} (linux)"
        # cat $file | grep -e "osx_alias" | cut -d" " -f2 | xargs -I{} echo "|  ├─ {} (osx)"
        # cat $file | grep -e "function "  |xargs -L1 | cut -d" " -f2 | xargs  -I{}  echo "|  ├─ {} (function)"
    done
    result=$(echo $result | sort -k1,1 -k4,4r -t "$table_spacer" )
    echo "Type${table_spacer}File${table_spacer}Alias${table_spacer}Enabled${table_spacer}Command\n$result"  | column -t -s"$table_spacer"
    
    #
}

${DOT_PREFIX}.alias.enable(){
    
    if [ "$#" -eq 1 ]; then
        enabled=$(${DOT_PREFIX}.config.get "aliases.$1.enabled" true)
        echo "$enabled => true"
        ${DOT_PREFIX}.config.set "aliases.$1.enabled" true
        
    else
        echo "${DOT_PREFIX}.alias.enable <alias-name>"
    fi
}
${DOT_PREFIX}.alias.disable(){
    
    if [ "$#" -eq 1 ]; then
        enabled=$(${DOT_PREFIX}.config.get "aliases.$1.enabled" true)
        echo "$enabled => false"
        ${DOT_PREFIX}.config.set "aliases.$1.enabled" false
        
    else
        echo "${DOT_PREFIX}.alias.disable <alias-name>"
    fi
}

for file in $(find $ZSH_ALIASES_CONFIG_ROOT -name "*.zsh" -type f); do
    name=$(basename $file)
    name="${name/".zsh"/""}"
    enabled=$(${DOT_PREFIX}.config.get "aliases.$name.enabled" true)
    if [ $enabled = "true" ];
    then
        DEBUG "Parse aliases in $file"
        source $file
    else
        DEBUG "Skip disabled alias file $file"
    fi
done
# function dot.alias.setup(){
#     # alias  helper functions

#     # load all aliases in folder
# }