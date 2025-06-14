#!/usr/bin/env nu

let dir = "/home/lajope/.custom/scripts/"

let xr = (xrandr --listmonitors)

print ($xr | split row "\n" | drop nth 0 | split column " " | select column6 column4)
