# flags
defineCommonAlias zsh.flags 'echo $ALL_FLAGS[*]' # list all availaible flags

function zsh.aliases.list(){
    echo "Pl"
    x=$(alias | cut -d"=" -f1)
    echo $x
}