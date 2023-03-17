
local function __log() {
    COLOR=$1
    NC='\033[0m'
    enabled=$(${DOT_PREFIX}.config.get "log.$2.enabled" false)
    if [ $enabled = "true" ];
    then
        echo "${COLOR}[$2] ${@:3}$NC"
    fi
}

# print only if debug flag is set
function DEBUG () {
    # do not use dot.flag.check here!!!
    __log $BLUE "debug" "$@"
}
function DEBUG_ALIASES () {
    # do not use dot.flag.check here!!!
    __log $BLUE "debug-aliases" "$@"
}
# print only if verbose flag is set
function VERBOSE () {
    # do not use dot.flag.check here!!!
    __log $CYAN "verbose" "$@"
    
}

function INFO() {
    __log $YELLOW "info" "$@"
    
}

