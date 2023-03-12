
local function __log() {
    COLOR=$1
    NC='\033[0m'
    echo "${COLOR}[$2] ${@:3}$NC"
}

# print only if debug flag is set
function DEBUG () {
    # do not use dot.flag.check here!!!
    FLAG="$FLAG_ROOT/debug$ZSH_FLAG_EXT"
    if test -f "$FLAG"; then
        __log $BLUE "DEBUG" "$@"
    fi
}
function DEBUG_ALIASES () {
    # do not use dot.flag.check here!!!
    FLAG="$FLAG_ROOT/debug-aliases$ZSH_FLAG_EXT"
    if test -f "$FLAG"; then
        __log $BLUE "DEBUG_ALIASES" "$@"
    fi
}
# print only if verbose flag is set
function VERBOSE () {
    # do not use dot.flag.check here!!!
    FLAG="$FLAG_ROOT/verbose$ZSH_FLAG_EXT"
    if test -f "$FLAG"; then
        __log $CYAN "VERBOSE" "$@"
    fi
}

function INFO() {
    __log $YELLOW "INFO" "$@"
}

