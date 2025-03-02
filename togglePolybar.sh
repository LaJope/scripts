#!/bin/bash

is_active=$(pgrep polybar)
startScript="$HOME/.config/polybar/launch_polybar.sh"

if [[ $is_active = '' ]]; then
  $startScript
else
  killall polybar
fi
