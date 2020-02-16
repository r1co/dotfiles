source $ZSH_ROOT/alias.functions.zsh

# Easier navigation: .., ..., ...., .....
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Folder Shortcuts
alias d='cd ~/Downloads'
alias w='cd $(cat $ZSH_WORKSPACE_PATH_FILE)'

# Workspace Shortcuts
alias ws.print='echo Workspace: $(cat $ZSH_WORKSPACE_PATH_FILE)'
alias ws.set='pwd > $ZSH_WORKSPACE_PATH_FILE'
alias ws.setpath='echo $1 > $ZSH_WORKSPACE_PATH_FILE'

# untar
alias untar='tar -zxvf '

## UTILS
# webserver from current folder
alias util.webserver='python -m SimpleHTTPServer 8000'
# Print each PATH entry on a separate line
alias util.path='echo -e ${PATH//:/\\n}'
# unix timestamp
alias util.ts='date +"%s"'
# URL-encode strings
alias util.urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'
# print term colours
alias util.print-xterm256='curl -s https://gist.githubusercontent.com/HaleTom/89ffe32783f89f403bba96bd7bcd1263/raw/ | bash'

#date
alias date.week="date +%V"
alias date.simple='date +"%d.%m.%y"'

# find
alias find.file='findFile'
alias find.inFile='findInFile'
alias find.bigFiles='findBigFiles'
alias find.dir='findDir'

# network
alias ip.all='{echo extern $(ip.ext); ip route | cut -d" " -f3,6,9 | grep scope | cut -d" " -f1,3} | column -t'
alias ip.ext='curl -s ipinfo.io/ip'
alias ip.lan='net.status | grep ethernet | cut -d" " -f1 | xargs -i zsh -c "ip route | grep {} | grep scope | cut -d\" \" -f9"'
alias ip.wifi='net.status | grep wifi | cut -d" " -f1 | xargs -i zsh -c "ip route | grep {} | grep scope | cut -d\" \" -f9"'
alias ip.scan='nmap -sP '
alias net.status='nmcli device status'
alias net.connections='nmcli connection show'
alias net.routes='ip route | column -t'

# password generation
alias pw8='openssl rand -base64 8'
alias pw16='openssl rand -base64 16'
alias pw32='openssl rand -base64 32'

# docker
alias d.ps="docker ps --format \"{{.ID}}: {{.Names}} '{{.Status}}' '{{.Ports}}'\" | column -t -s \"'\" "
alias d.psa="docker ps -a --format \"{{.ID}}: {{.Names}} '{{.Status}}' '{{.Ports}}'\" | column -t -s \"'\""
alias d.run='docker run -it'  # run docker container in fg
alias d.runBg='docker run -d' # run docker container in bg
alias d.rmStopped='docker ps -a | grep Exited | cut -d" " -f1 | xargs -L1 docker rm'
alias d.rmCreated='docker ps -a | grep Created | cut -d" " -f1 | xargs -L1 docker rm'
alias d.log='docker logs -f '
# docker-compose
alias dc.up='docker-compose up'
alias dc.ps='docker-compose ps'
alias dc.sp='docker-compose stop'
alias dc.re='docker-compose restart'

# system
alias sys.ports='sudo netstat -tulanp'
alias sys.pid='getPidAndCommand'
alias sys.upud='sudo apt update && sudo apt upgrade'

# flags
alias zsh.flags='echo $ALL_FLAGS[*]' # list all availaible flags

# dotfile commands
alias dot.update='cd ~/.dotfiles && git pull'

# tmux commands
alias tmux.kill-server="tmux kill-server"
alias tmux.kill="alias.tmux.kill" # kill session
alias tmux.kill-others="alias.tmux.killOthers" # kill session
alias tmux.n="tmux new-session -d -s"
alias tmux.ns="alias.tmux.newIfNotExistAndSwitch"
alias tmux.s="tmux switch-client -t "
alias tmux.switch="tmux switch-client -t "
alias tmux.res="tmux rename-session"
alias tmux.rew="tmux rename-window"
alias tmux.reload="tmux source-file ~/.tmux.conf \;" # tmux display-message "~/.tmux.conf reloaded""
