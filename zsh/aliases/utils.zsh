
# return
## UTILS
# webserver from current folder
common_alias util.webserver 'python -m SimpleHTTPServer 8000'
# Print each PATH entry on a separate line
common_alias util.path 'echo -e ${PATH//:/\\n}'
# unix timestamp
common_alias util.ts 'date +"%s"'
# URL-encode strings
common_alias util.urlencode 'python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'
# print term colours
common_alias util.print-xterm256 'curl -s https://gist.githubusercontent.com/HaleTom/89ffe32783f89f403bba96bd7bcd1263/raw/ | bash'

