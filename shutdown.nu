#!/usr/bin/env nu

let variants = [
  [type, function];
  ["shutdown", {systemctl poweroff}],
  ["restart", {systemctl reboot}],
]

let opts = $variants | get type | to nuon

let width = 10
let msg = "Power"

let sel = try {
  dmenuSelect.nu $opts $msg --width=($width)
} catch {
  exit 0
}

do ($variants | where type == $sel | get 0.function)
