

# get config option
# config key - $1
# config default - $2
function ${DOT_PREFIX}.config.get() {
    ${DOT_PREFIX}.config.setup
    local config_key=$1
    local default_value=$2
    local config_file="$OPTIONS_ROOT/$config_key"
    if ! test -f "$config_file"; then
        echo $default_value > $config_file
    fi
    
    cat $config_file
}

# set config option
# config key - $1
# config default - $2
function ${DOT_PREFIX}.config.set() {
    ${DOT_PREFIX}.config.setup
    local config_key=$1
    local value=$2
    local config_file="$OPTIONS_ROOT/$config_key"
    echo $value > $config_file
    
}

# reset all config
function ${DOT_PREFIX}.config.reset() {
    rm -rf $OPTIONS_ROOT
    ${DOT_PREFIX}.config.setup
}

function ${DOT_PREFIX}.config.list(){
    ${DOT_PREFIX}.config.setup
    local result=""
    for file in $(find $OPTIONS_ROOT -name "*" -type f); do
        name=$(basename $file)
        result="${result}\n$name - $(${DOT_PREFIX}.config.get $name)"
    done
    echo $result | column -t -s' ' | sort
}

# setup config environment
function ${DOT_PREFIX}.config.setup() {
    # make sure options root exists
    mkdir -p $OPTIONS_ROOT
}