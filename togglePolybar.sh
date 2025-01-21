#!/bin/bash

is_active=$(pgrep polybar)

if [[ $is_active = '' ]]; then
  ~/.config/polybar/launch_polybar.sh
else
  killall polybar
fi
