#compdef .dot.module.enable

function _module_keys() {
    local state
    
    _arguments \
    '1: :->config_key' #\
    # '*: :->eb_name'
    
    keys_str=$(${DOT_PREFIX}.module.list | xargs -L1 | cut -d" " -f1 )
    
    case $state in
    (config_key) _arguments "1:module:($keys_str)" ;;
    # (*) compadd "$@" prod staging dev
    esac
}

_module_keys "$@"
