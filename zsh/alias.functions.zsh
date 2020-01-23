
function alias.tmux.newIfNotExistAndSwitch() {
    tmux has-session -t $session 2>/dev/null
    if [ $? != 0 ]; then
        tmux new-session -d -s $1
    fi
    tmux switch-client -t $1
}

function alias.tmux.kill() {
    if [ -z $1 ]; then
      tmux kill-session
    else
      tmux kill-session -t $1
    fi
}

function alias.tmux.killOthers() {
    current_id=$(tmux display-message -p '#S')
    tmux list-sessions | grep -v "$current_id: " | cut -d: -f1 | xargs -i tmux kill-session -t {}
}
