

# get config option
# config key - $1
# config default - $2
function dot.config.get() {
    local config_key=$1
    local default_value=$2
    local config_file="$OPTIONS_ROOT/$config_key"
    if ! test -f "$config_file"; then
        # DEBUG "[OPTIONS] Config $config_key does not exist. Create default."
        echo $default_value > $config_file
    fi
    
    cat $config_file
}

# set config option
# config key - $1
# config default - $2
function dot.config.set() {
    local config_key=$1
    local value=$2
    local config_file="$OPTIONS_ROOT/$config_key"
    echo $value > $config_file
    
}

# reset all config
function dot.config.reset() {
    rm -rf $OPTIONS_ROOT
    mkdir -p $OPTIONS_ROOT
}

function dot.config.list(){
    local result=""
    for file in $(find $OPTIONS_ROOT -name "*" -type f); do
        name=$(basename $file)
        result="${result}\n$name - $(dot.config.get $name)"
    done
    echo $result | column -t -s' '
}

# setup config environment
function dot.config.setup() {
    DEBUG "LOAD OPTIONS!"
    
    # make sure options root exists
    mkdir -p $OPTIONS_ROOT
}