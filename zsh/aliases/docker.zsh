# docker
dot.alias.define.common d.ps "docker ps --format \"{{.ID}}: {{.Names}} '{{.Status}}' '{{.Ports}}'\" | column -t -s \"'\" "
dot.alias.define.common d.psa "docker ps -a --format \"{{.ID}}: {{.Names}} '{{.Status}}' '{{.Ports}}'\" | column -t -s \"'\""
dot.alias.define.common d.run 'docker run -it'  # run docker container in fg
dot.alias.define.common d.runBg 'docker run -d' # run docker container in bg
dot.alias.define.common d.rmStopped 'docker ps -a | grep Exited | cut -d" " -f1 | xargs -L1 docker rm'
dot.alias.define.common d.rmCreated 'docker ps -a | grep Created | cut -d" " -f1 | xargs -L1 docker rm'
dot.alias.define.common d.log 'docker logs -f '
# docker-compose
dot.alias.define.common dc.up 'docker-compose up'
dot.alias.define.common dc.ps 'docker-compose ps'
dot.alias.define.common dc.sp 'docker-compose stop'
dot.alias.define.common dc.re 'docker-compose restart'