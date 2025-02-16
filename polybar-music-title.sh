#!/bin/bash

player=$1
response="$(playerctl --player="$player" status 2>&1)"

case $response in
  'Playing') echo "$(playerctl --player="$player" metadata xesam:title) ($(playerctl --player="$player" metadata xesam:artist))" ;;
  'Paused') echo '' ;;
  '*') echo '' ;;
esac
