# print only if debug flag is set
function DEBUG () {
    # do not use checkFlag here!!!
    FLAG="$FLAG_ROOT/debug$ZSH_FLAG_EXT"
    if test -f "$FLAG"; then
        echo "DEBUG: $1"
    fi
}
function DEBUG_ALIASES () {
    # do not use checkFlag here!!!
    FLAG="$FLAG_ROOT/debug-aliases$ZSH_FLAG_EXT"
    if test -f "$FLAG"; then
        echo "DEBUG: $1"
    fi
}