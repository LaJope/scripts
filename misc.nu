#!/usr/bin/env nu

let dir = "/home/lajope/.custom/scripts/"

let scripts = [
  [name, path];
  ["kill", "killprompt.sh"],
  ["audio", "switchAudioOutput.nu"],
  ["ghostty", "runGhosttyShader.sh"],
  ["monitor", "multimonitor.sh"],
]

let options = $scripts | get name | enumerate |
              format pattern "{index} {item}" | to text

let len = $scripts | length
let width = 20
let msg = "Script"

let sel = try {
  nu ($dir + "dmenuSelect.nu") $options $len $msg --width=($width)
} catch {
  exit 0
}

let scr = $scripts | where name == $sel | get path | to text

^($dir + $scr | str trim)
