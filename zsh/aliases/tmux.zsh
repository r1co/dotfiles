
# tmux command
dot.alias.define.linux tmux.kill-server "tmux kill-server"
dot.alias.define.linux tmux.n "tmux new-session -d -s"
dot.alias.define.linux tmux.s "tmux switch-client -t"
dot.alias.define.linux tmux.switch "tmux switch-client -t"
dot.alias.define.linux tmux.res "tmux rename-session"
dot.alias.define.linux tmux.rew "tmux rename-window"
dot.alias.define.linux tmux.reload "tmux source-file ~/.tmux.conf \;"

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




