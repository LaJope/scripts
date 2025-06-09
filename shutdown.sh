#!/bin/zsh

array=("shutdown" "restart" "cancel");
for ((i = 1; i <= $#array; i++))
  array[i]="$i "$array[i]

length="${#array[@]}"
theme_rofi="window {width: 10%;}"

prompt="${(j:\n:)array}"
message="Power"

select_rofi=$(echo "$prompt" | \
  rofi -dmenu -l "$length" -i -theme-str "$theme_rofi" -p "$message")
input=$(echo $select_rofi | awk '{print $2}')

case "$input" in
  shutdown) shutdown -h now ;;
  restart) shutdown -h now -r ;;
  cancel) exit 0 ;;
esac
