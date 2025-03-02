#!/bin/bash

is_active=$(pgrep daktilo)
config="$HOME//.config/daktilo/daktilo.toml"
preset="default"


if [[ $is_active = '' ]]; then
  daktilo --device=pipewire --config="$config" --preset="$preset"
else
  killall daktilo
fi
