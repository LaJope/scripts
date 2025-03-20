#!/bin/bash

vlcon="$(pgrep vlc)"

if [[ $vlcon ]]; then
    title=$(playerctl --player=vlc metadata xesam:title)
    artist=$(playerctl --player=vlc metadata xesam:artist)
    echo "$title ($artist)"
else
  player=$1
  response="$(playerctl --player="$player" status 2>&1)"

  case $response in
    'Playing') title=$(playerctl --player="$player" metadata xesam:title)
               artist=$(playerctl --player="$player" metadata xesam:artist)
               echo "$title ($artist)" ;;
    'Paused')  echo '' ;;
    '*')       echo '' ;;
  esac
fi
