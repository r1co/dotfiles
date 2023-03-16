
# Define a flag.
# dot.flag.define "<flag-name>" <handlerfn>
declare -a ALL_FLAGS=()

function dot.flag.define () {
    DEBUG "dot.flag.define '$1'"
    FLAG_EXT=$3
    
    ALL_FLAGS+=($1)
    
    ENABLE_ALIAS_NAME="dot.flag.enable.$1"
    DISABLE_ALIAS_NAME="dot.flag.disable.$1"
    
    # define flag enable/disable aliases
    alias $ENABLE_ALIAS_NAME="touch $FLAG_ROOT/$1$FLAG_EXT && ${2}_onEnable"
    alias $DISABLE_ALIAS_NAME="rm -f $FLAG_ROOT/$1$FLAG_EXT && ${2}_onDisable"
    
    DEBUG "[FLAG]" "alias $ENABLE_ALIAS_NAME created"
    DEBUG "[FLAG]" "alias $DISABLE_ALIAS_NAME created"
    
    if dot.flag.check $1 $FLAG_EXT; then
        $2
    fi
}

# Check if flag is set
function dot.flag.check () {
    local FLAG_EXT=$2
    FLAG="$FLAG_ROOT/$1$FLAG_EXT"
    if test -f "$FLAG"; then
        DEBUG "[FLAG]" "flag $1 is enabled"
        return 0;
    fi
    DEBUG "[FLAG]" "flag $1 is disabled"
    return 1;
}

function dot.flag.define.zsh () {
    dot.flag.define $1 $2 $ZSH_FLAG_EXT
}


# flag helper functions
function dot.flags(){
    echo "Flags: "
    for flag in $ALL_FLAGS[*]
    do
        ENABLED='false'
        if dot.flag.check $flag $FLAG_EXT; then
            ENABLED='true'
        fi
        echo "$flag - $(${FLAG_RUNNER_PREFIX}.${flag}_info) (enabled: $ENABLED)"
    done
}

function dot.flag.setup(){
    
    
    # make sure flag root exists
    mkdir -p $FLAG_ROOT
    # parse flag handlers. each handler is added as flag option.
    for file in $(find $ZSH_FLAG_CONFIG_ROOT -name "*$ZSH_FLAG_HANDLER_EXT" -type f); do
        name=$(basename $file)
        name="${name/"$ZSH_FLAG_HANDLER_EXT"/""}"
        HANDLER_NAME="$FLAG_RUNNER_PREFIX.$name"
        
        # default handler for onEnable/onDisable
        function ${HANDLER_NAME}_onEnable(){
            INFO "[FLAG]" "$HANDLER_NAME enabled"
        }
        
        function ${HANDLER_NAME}_onDisable(){
            INFO "[FLAG]" "$HANDLER_NAME disabled"
        }
        
        function ${HANDLER_NAME}_info(){
            echo "Has no description"
        }
        
        # source the handler file
        source $file
        
        dot.flag.define.zsh "$name" $HANDLER_NAME
    done
}