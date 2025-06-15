#!/usr/bin/env nu

let msg = "Rotate"
let monitor = try { selectMonitor.nu $msg -c } catch { exit 0 }

let variants = ["left", "right", "normal", "inverted"]

let opts = $variants | to nuon

let width = 20
let msg = "Orientation"

let sel = try {
  dmenuSelect.nu $opts $msg --width=($width)
} catch {
  exit 0
}

xrandr --output $monitor --rotate $sel
