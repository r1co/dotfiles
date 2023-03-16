function ${DOT_PREFIX}.update() {
    cd $DOTFILES_ROOT
    git pull
}

function ${DOT_PREFIX}.status() {
    cd $DOTFILES_ROOT
    git status
}

function ${DOT_PREFIX}.save(){
    if [ -n "${1+1}" ]; then
        cd $DOTFILES_ROOT
        git add *
        git commit -m "$*"
        git pull
        git push
    else
        printRed "Please provide commit message"
    fi
}