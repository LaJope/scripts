#!/bin/zsh

intern="eDP-1"
extern="HDMI-1-0"

array=("disconnect" "extra to the right" "duplicate" "cancel")
for ((i = 1; i <= $#array; i++))
  array[i]="$i "$array[i]

length="${#array[@]}"
theme_rofi="window {width: 15%;}"

prompt="${(j:\n:)array}"
message="Monitor"

select_rofi=$(echo "$prompt" | \
  rofi -dmenu -l "$length" -i -theme-str "$theme_rofi" -p "$message")
input=$(echo $select_rofi | awk '{print $2}')

case "$input" in
  disconnect) xrandr --output "$extern" --off --output "$intern" --auto ;;
  extra)      xrandr --output "$intern" --primary --output "$extern" --mode 1920x1080 --right-of "$intern" ;;
  duplicate)  xrandr --output "$intern" --primary --output "$extern" --mode 1920x1080 --same-as "$intern" ;;
  cancel)     exit 0 ;;
esac
