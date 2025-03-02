#!/bin/bash

is_active=$(pgrep feh)
bgFolder="$HOME/HDD/Background/"

if [[ $is_active != '' ]]; then
  killall feh
fi

feh --bg-fill --randomize "$bgFolder"
