# docker
defineCommonAlias d.ps "docker ps --format \"{{.ID}}: {{.Names}} '{{.Status}}' '{{.Ports}}'\" | column -t -s \"'\" "
defineCommonAlias d.psa "docker ps -a --format \"{{.ID}}: {{.Names}} '{{.Status}}' '{{.Ports}}'\" | column -t -s \"'\""
defineCommonAlias d.run 'docker run -it'  # run docker container in fg
defineCommonAlias d.runBg 'docker run -d' # run docker container in bg
defineCommonAlias d.rmStopped 'docker ps -a | grep Exited | cut -d" " -f1 | xargs -L1 docker rm'
defineCommonAlias d.rmCreated 'docker ps -a | grep Created | cut -d" " -f1 | xargs -L1 docker rm'
defineCommonAlias d.log 'docker logs -f '
# docker-compose
defineCommonAlias dc.up 'docker-compose up'
defineCommonAlias dc.ps 'docker-compose ps'
defineCommonAlias dc.sp 'docker-compose stop'
defineCommonAlias dc.re 'docker-compose restart'
