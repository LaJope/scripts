#!/usr/bin/env nu

let monitors = (getMonitors.nu) | from nuon

let opts = $monitors | get name | to nuon

let width = 20
let msg = "Primary"

let sel = try {
  dmenuSelect.nu $opts $msg --fuzzy --width=($width)
} catch {
  exit 0
}

$sel
