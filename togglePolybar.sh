#!/bin/bash

startScript="$HOME/.config/polybar/launch_polybar.sh"

if [[ $(pgrep polybar) ]]; then
  killall polybar
else
  $startScript
fi
