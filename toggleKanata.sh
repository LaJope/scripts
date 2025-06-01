#!/bin/bash

config_file="$HOME/.config/kanata/config_toggle.kbd"

if [[ $(pgrep kanata) ]]; then
  killall kanata
else
  kanata --cfg "$config_file"
fi
