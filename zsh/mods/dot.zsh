function dot.update() {
    cd $DOTFILES_ROOT
    git pull
}

function dot.status() {
    cd $DOTFILES_ROOT
    git status
}

function dot.save(){
    if [ -n "${1+1}" ]; then
        cd $DOTFILES_ROOT
        git add *
        git commit -m "'$*'"
        git push
    else
        printRed "Please provide commit message"
    fi
}