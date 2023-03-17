#compdef .dot.config.get

_config_keys() {
    local state
    
    _arguments \
    '1: :->config_key' #\
    # '*: :->eb_name'
    
    keys_str=$(${DOT_PREFIX}.config.list | xargs -L1 | cut -d" " -f1 )
    
    case $state in
    (config_key) _arguments "1:config_key:($keys_str)" ;;
    # (*) compadd "$@" prod staging dev
    esac
}

_config_keys "$@"
