#!/bin/bash

is_active=$(pgrep screenkey)

if [[ $is_active = '' ]]; then
  screenkey
else
  killall screenkey
fi
