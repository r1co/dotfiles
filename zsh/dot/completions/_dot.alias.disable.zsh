#compdef .dot.alias.disable

_alias_keys() {
    local state
    
    _arguments \
    '1: :->config_key' #\
    # '*: :->eb_name'
    
    keys_str="TODO"
    
    case $state in
    (config_key) _arguments "1:config_key:($keys_str)" ;;
    # (*) compadd "$@" prod staging dev
    esac
}

_alias_keys "$@"
