#!/usr/bin/env nu

let dir = "/home/lajope/.custom/scripts/"

let int = "eDP-1"
let ext = "HDMI-1-0"
let res = "1920x1080"

let variants = [
  [type, function];
  ["disconnect", {xrandr --output $ext --off --output $int --auto}],
  ["extra to the right", {xrandr --output $int --primary --output $ext --mode $res --right-of $int}],
  ["duplicate", {xrandr --output $int --primary --output $ext --mode $res --same-as $int}]
]

let opts = $variants | get type | to nuon

let len = $variants | length
let width = 20
let msg = "Monitor"

let sel = try {
  nu ($dir + "/dmenuSelect.nu") $opts $len $msg --width=($width)
} catch {
  exit 0
}

do ($variants | where type == $sel | get 0.function)
