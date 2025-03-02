#!/bin/bash

player=$1
response="$(playerctl --player="$player" status 2>&1)"

case $response in
  'Playing') title=$(playerctl --player="$player" metadata xesam:title)
             artist=$(playerctl --player="$player" metadata xesam:artist)
             echo "$title ($artist)" ;;
  'Paused')  echo '' ;;
  '*')       echo '' ;;
esac
