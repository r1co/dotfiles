function noop() {
    
}

function getPlatform() {
    if [[ "$(uname)" == "Darwin" ]]; then
        echo "Darwin"
        return "Darwin"
        elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then
        echo "Linux"
        return "Linux"
    fi
    echo "Unkown"
    return "Unkown"
}

function isDarwin() {
    platform=$(getPlatform)
    if [[ "$platform" == "Darwin" ]]; then
        echo true
        return true
    fi
    echo false
    return false
}

function isLinux() {
    platform=$(getPlatform)
    if [[ "$platform" == "Linux" ]]; then
        echo true
        return true
    fi
    echo false
    return false
}