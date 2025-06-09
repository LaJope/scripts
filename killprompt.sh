#!/bin/zsh

length=10
theme_rofi="window {width: 30%;}"

prompt="$(ps -e -o pid,comm --no-headers)"
message="kill"

select_rofi=$(echo "$prompt" | \
  rofi -matching fuzzy -dmenu -l "$length" -i -theme-str "$theme_rofi" -p "$message") || exit 0
input=$(echo $select_rofi | awk '{print $1}')
kill $input
