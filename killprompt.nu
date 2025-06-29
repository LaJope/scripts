#!/usr/bin/env nu

let processes = (ps --long | where user_id != 0 | select pid name)
let ignore = [
  "Qt", "kworker", "dbus", "xdg", "at-spi",
  "systemd", "sd-pam", "ksecretd", "pipewire",
  "wireplumber", "rtkit-daemon", "polkitd",
  "-discover", "electron", "clang"
]
let filt = {|el| ($ignore | all {|ig| $el.name !~ $ig})}

let pattern = "({pid}) {name}"

let filtered = ($processes | where $filt)
let opts = ($filtered | format pattern $pattern | to nuon)

let len = [10, ($filtered | length)] | math min
let width = 20
let msg = "Kill"

let sel = try {
  dmenuSelect.nu $opts $msg -l $len --width $width
} catch {
  exit 0
}

let pid = $sel | parse $pattern | get 0.pid | into int
kill $pid
