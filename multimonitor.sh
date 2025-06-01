#!/bin/bash

intern="eDP-1"
extern="HDMI-1-0"

array=("disconnect" "extra to the right" "duplicate" "cancel")
PS3="Choose: "

select input in "${array[@]}"; do
  case "$input" in
    "disconnect") xrandr --output "$extern" --off --output "$intern" --auto ;;
    "extra to the right") xrandr --output "$intern" --primary --output "$extern" --mode 1920x1080 --right-of "$intern" ;;
    "duplicate") xrandr --output "$intern" --primary --output "$extern" --mode 1920x1080 --same-as "$intern" ;;
    "cancel") exit 0 ;;
  esac
  break;
done

