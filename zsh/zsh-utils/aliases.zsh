
function defineCommonAlias() {
    name=$1
    command=$2
    
    DEBUG_ALIASES "Add common alias $name"
    alias $name=$command
}

function defineLinuxAlias() {
    name=$1
    command=$2
    
    if [[ "$(isLinux)" == true ]]; then
        DEBUG_ALIASES "Add linux alias $name"
        alias $name=$command
    else
        DEBUG_ALIASES "Ignore alias $name for platform $(getPlatform)"
    fi
}

function defineOSXAlias() {
    name=$1
    command=$2
    
    if [[ "$(isDarwin)" == true ]]; then
        DEBUG_ALIASES "Add osx alias $name"
        alias $name=$command
    else
        DEBUG_ALIASES "Ignore alias $name for platform $(getPlatform)"
    fi
}
