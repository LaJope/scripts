#!/bin/bash

function getMusic {
  player=$1
  title=$(playerctl --player="$player" metadata xesam:title)
  artist=$(playerctl --player="$player" metadata xesam:artist)
  echo "$title ($artist)"
}

if [ "$#" == 1 ]; then
  player=$1
  response="$(playerctl --player="$player" status 2>&1)"

  case $response in
    'Playing') getMusic "$player" ;;
    'Paused')  echo 'Paused' ;;
    '*')       echo '' ;;
  esac
else
  vlcon="$(pgrep vlc)"
  if [[ $vlcon ]]; then
    getMusic "vlc"
  else
    echo ''
  fi
fi

