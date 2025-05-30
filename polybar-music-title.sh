#!/bin/bash

function getMusic {
  player=$1
  title=$(playerctl --player="$player" metadata xesam:title)
  artist=$(playerctl --player="$player" metadata xesam:artist)
  echo "$title ($artist)"
}

function anotherPlayer {
  ffoxstatus="$(playerctl --player="firefox" status 2>&1)"
  ffoxsite="$(playerctl --player="firefox" metadata 2>&1 | grep 'music.yandex')"
  if [[ $(pgrep vlc) ]]; then
    getMusic "vlc"
  elif [[ $ffoxstatus == 'Playing' && $ffoxsite != "" ]]; then
    getMusic "firefox"
  fi
}

if [ "$#" == 1 ]; then
  player=$1
  response="$(playerctl --player="$player" status 2>&1)"

  case $response in
    'Playing') echo "hello" ; getMusic "$player" ;;
    'Paused')  anotherPlayer ; echo 'Paused' ;;
    *) anotherPlayer ;;
  esac
else
    anotherPlayer
fi

echo ''
