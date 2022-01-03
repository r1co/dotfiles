source $ZSH_ROOT/alias.functions.zsh

# Easier navigation: .., ..., ...., .....
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Folder Shortcuts
alias d='cd ~/Downloads'

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

# dns
function dig.rootNS() {
  ROOT_SERVER=$(dig NS +noadditional +noquestion +nocomments +nocmd +nostats | head -1 | xargs -L1 | cut -d' ' -f5)
  echo "> $ROOT_SERVER"
  FIRST_LEVEL_DNS=$(dig NS +noadditional +noquestion +nocomments +nocmd +nostats @$ROOT_SERVER $1 | head -1 | xargs -L1 | cut -d' ' -f5)
  echo ">> $FIRST_LEVEL_DNS"
  NS_SERVER=$(dig  +noquestion +nocomments +nocmd +nostats @$FIRST_LEVEL_DNS $1 | grep NS | xargs -L1 | cut -d' ' -f5);
  echo $NS_SERVER | while read ns_server ; do
    GLUE_RECORD=$(dig  +noquestion +nocomments +nocmd +nostats @$FIRST_LEVEL_DNS $1 | grep A | grep $ns_server |  xargs -L1 | cut -d' ' -f5)
    if [ ! -z "$GLUE_RECORD" ]
    then
      echo ">>> $ns_server ($(echo $GLUE_RECORD |  tr '\n' ' ' | xargs -L1))"
    else
      echo ">>> $ns_server"
    fi
  done
}

# password generation
alias pw8='openssl rand -base64 8'
alias pw16='openssl rand -base64 16'
alias pw32='openssl rand -base64 32'

# docker
#alias docker="podman"
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
alias tmux.n="tmux new-session -d -s"
alias tmux.s="tmux switch-client -t "
alias tmux.switch="tmux switch-client -t "
alias tmux.res="tmux rename-session"
alias tmux.rew="tmux rename-window"
alias tmux.reload="tmux source-file ~/.tmux.conf \;" # tmux display-message "~/.tmux.conf reloaded""

# linux
alias open="flatpak run re.sonny.Junction"