
# tmux command
linux_alias tmux.kill-server "tmux kill-server"
linux_alias tmux.n "tmux new-session -d -s"
linux_alias tmux.s "tmux switch-client -t"
linux_alias tmux.switch "tmux switch-client -t"
linux_alias tmux.res "tmux rename-session"
linux_alias tmux.rew "tmux rename-window"
linux_alias tmux.reload "tmux source-file ~/.tmux.conf \;"

function tmux.ns() {
    tmux has-session -t $session 2>/dev/null
    if [ $? != 0 ]; then
        tmux new-session -d -s $1
    fi
    tmux switch-client -t $1
}

function tmux.kill() {
    if [ -z $1 ]; then
        tmux kill-session
    else
        tmux kill-session -t $1
    fi
}

function tmux.kill-others() {
    current_id=$(tmux display-message -p '#S')
    tmux list-sessions | grep -v "$current_id: " | cut -d: -f1 | xargs -i tmux kill-session -t {}
}




