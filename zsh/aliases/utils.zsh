
# return
## UTILS
# webserver from current folder
dot.alias.define.common util.webserver 'python -m SimpleHTTPServer 8000'
# Print each PATH entry on a separate line
dot.alias.define.common util.path 'echo -e ${PATH//:/\\n}'
# unix timestamp
dot.alias.define.common util.ts 'date +"%s"'
# URL-encode strings
dot.alias.define.common util.urlencode 'python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'
# print term colours
dot.alias.define.common util.print-xterm256 'curl -s https://gist.githubusercontent.com/HaleTom/89ffe32783f89f403bba96bd7bcd1263/raw/ | bash'

