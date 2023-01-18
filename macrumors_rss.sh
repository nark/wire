#!/bin/bash
#

RSS_URL="https://feeds.macrumors.com/MacRumors-All"

function read_rss {
  say=$( curl --silent "$RSS_URL" | \
  grep -E '(title>|description>)' | \
  tail -n +4 | \
  sed -e 's/^[ \t]*//' | \
  sed -e 's/<title>//' -e 's/<\/title>//' -e 's/<description>/  /' -e 's/<\/description>//' | \
  head -n 1 | sed -e 's/.*CDATA\[//g' -e 's/<br\/>//g' -e 's/<\/a>//g' -e 's/<a href="//g' -e 's/\">/\ /g' )
}

last=""
while true
do
  now="$(curl "$RSS_URL" 2> /dev/null | grep pubDate | head -1)"
  test "$last" != "$now" && read_rss &&  echo toll #screen -S wirebot -p0 -X stuff "$say"^M
  last="$now"
  sleep 5m
done