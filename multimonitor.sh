#!/bin/bash

intern="eDP-1"
extern="HDMI-1-0"

printf "1 - disconnect\n2 - extra to the right\n3 - duplicate\nChoose: "

input=""

read -r input

case "$input" in
  "1") xrandr --output "$extern" --off --output "$intern" --auto ;;
  "2") xrandr --output "$intern" --primary --output "$extern" --mode 1920x1080 --right-of "$intern" ;;
  "3") xrandr --output "$intern" --primary --output "$extern" --mode 1920x1080 --same-as "$intern" ;;
  "*") xrandr --output "$extern" --off --output "$intern" --auto ;;
esac

