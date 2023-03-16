# network
common_alias ip.all '{echo extern $(ip.ext); ip route | cut -d" " -f3,6,9 | grep scope | cut -d" " -f1,3} | column -t'
common_alias ip.ext 'curl -s ipinfo.io/ip'
common_alias ip.lan 'net.status | grep ethernet | cut -d" " -f1 | xargs -i zsh -c "ip route | grep {} | grep scope | cut -d\" \" -f9"'
common_alias ip.wifi 'net.status | grep wifi | cut -d" " -f1 | xargs -i zsh -c "ip route | grep {} | grep scope | cut -d\" \" -f9"'
common_alias ip.scan 'nmap -sP '
common_alias net.status 'nmcli device status'
common_alias net.connections 'nmcli connection show'
common_alias net.routes 'ip route | column -t'

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
