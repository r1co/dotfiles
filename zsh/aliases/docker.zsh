# docker
common_alias d.ps "docker ps --format \"{{.ID}}: {{.Names}} '{{.Status}}' '{{.Ports}}'\" | column -t -s \"'\" "
common_alias d.psa "docker ps -a --format \"{{.ID}}: {{.Names}} '{{.Status}}' '{{.Ports}}'\" | column -t -s \"'\""
common_alias d.run 'docker run -it'  # run docker container in fg
common_alias d.runBg 'docker run -d' # run docker container in bg
common_alias d.rmStopped 'docker ps -a | grep Exited | cut -d" " -f1 | xargs -L1 docker rm'
common_alias d.rmCreated 'docker ps -a | grep Created | cut -d" " -f1 | xargs -L1 docker rm'
common_alias d.log 'docker logs -f '
# docker-compose
common_alias dc.up 'docker-compose up'
common_alias dc.ps 'docker-compose ps'
common_alias dc.sp 'docker-compose stop'
common_alias dc.re 'docker-compose restart'