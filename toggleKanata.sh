#!/bin/bash

is_active=$(pgrep kanata)
config_file="$HOME/.config/kanata/config_toggle.kbd"

if [[ $is_active = '' ]]; then
  kanata --cfg $config_file
else
  killall kanata
fi
