#!/usr/bin/env nu

let monitors = getMonitors.nu | from nuon

for $monitor in ($monitors | get name) {
  with-env {MONITOR: $monitor} { polybar --reload mainbar }
}
