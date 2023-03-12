# Define a flag.
# defineFlag "<flag-name>" <handlerfn>
declare -a ALL_FLAGS=()


function defineFlag () {
    FLAG_EXT=$3
    FLAG_ALIAS_PREFIX=$4
    
    ALL_FLAGS+=($1)
    
    # define flag enable/disable aliases
    alias $FLAG_ALIAS_PREFIX.enable.$1="touch $FLAG_ROOT/$1$FLAG_EXT && echo '$1 enabled'"
    alias $FLAG_ALIAS_PREFIX.disable.$1="rm -f $FLAG_ROOT/$1$FLAG_EXT && echo '$1 disabled'"
    
    # DEBUG "alias $FLAG_ALIAS_PREFIX.enable.$1 created"
    # DEBUG "alias $FLAG_ALIAS_PREFIX.disable.$1 created"
    
    if checkFlag $1 $FLAG_EXT; then
        $2
    fi
}

# Check if flag is set
function checkFlag () {
    local FLAG_EXT=$2
    FLAG="$FLAG_ROOT/$1$FLAG_EXT"
    if test -f "$FLAG"; then
        DEBUG "flag: $1 enabled"
        return 0;
    fi
    DEBUG "flag: $1 disabled"
    return 1;
}

function defineZshFlag () {
    defineFlag $1 $2 $ZSH_FLAG_EXT $ZSH_FLAG_ALIAS_PREFIX
}

function defineTmuxFlag () {
    defineFlag $1 noop $TMUX_FLAG_EXT $TMUX_FLAG_ALIAS_PREFIX
}