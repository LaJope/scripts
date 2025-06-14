#!/bin/bash

player=$1

status=$(playerctl --player="$player" status 2>&1)

case $status in
  "Playing")
    echo '' ;;
  "Paused")
    echo '' ;;
  "*")
    echo " " ;;
esac
