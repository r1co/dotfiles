
local function __log() {
    local color=("$1")
    local logger_name=$2
    local message="${@:3}"
    enabled=$(${DOT_PREFIX}.config.get "log.$logger_name.enabled" false)
    if [ $enabled = "true" ];
    then
        print_color $color "[$logger_name] $message"
    fi
}

# print only if debug flag is set
function DEBUG () {
    __log $COLOR_INFO "debug" "$@"
}
function DEBUG_ALIASES () {
    __log $COLOR_INFO "debug-aliases" "$@"
}
# print only if verbose flag is set
function VERBOSE () {
    __log $COLOR_ACCENT "verbose" "$@"
    
}
function INFO() {
    __log $COLOR_INFO "info" "$@"
    
}

