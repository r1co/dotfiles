# setup plugin environment
function dot.plugin.setup() {
    DEBUG "Setup plugins"
    
    dot.plugin.loadEnabled
}

function dot.plugin.enable(){
    PLUGIN_FILE="$ZSH_PLUGIN_ROOT/$1.zsh"
    if test -f "$PLUGIN_FILE"; then
        dot.config.set "plugin.$1.enabled" true
        INFO "Plugin '$1' enabled"
    else
        INFO "Plugin '$1' not found!"
    fi
}

function dot.plugin.disable(){
    PLUGIN_FILE="$ZSH_PLUGIN_ROOT/$1.zsh"
    if test ! -f "$PLUGIN_FILE"; then
        INFO "Plugin '$1' not found!"
    fi
    
    dot.config.set "plugin.$1.enabled" false
    INFO "Plugin '$1' disabled"
}

# load all enabled plugins
function dot.plugin.loadEnabled() {
    for file in $(find $ZSH_PLUGIN_ROOT -name "*.zsh" -type f); do
        name=$(basename $file)
        name="${name/".zsh"/""}"
        # all plugins enabled by default
        enabled=$(dot.config.get "plugin.$name.enabled" true)
        
        if [ $enabled = "true" ];
        then
            DEBUG "Load enabled plugin '$name'"
            source $file
        else
            DEBUG "Plugin '$name' disabled"
        fi
    done
}