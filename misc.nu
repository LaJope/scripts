#!/usr/bin/env nu

let scripts = [
  [name, path];
  ["Kill", "killprompt.nu"],
  ["Audio", "switchAudioOutput.nu"],
  ["Ghostty shaders", "runGhosttyShader.nu"],
  ["Duplicate monitor", "duplicateMonitor.nu"],
  ["Rotate monitor", "rotateMonitor.nu"]
  ["Shutdown", "shutdown.nu"],
]

let opts = $scripts | get name | to nuon

let width = 20
let msg = "Script"

let sel = try {
  dmenuSelect.nu $opts $msg --width=($width)
} catch {
  exit 0
}

let scr = $scripts | where name == $sel | get path | to text | str trim

^($scr)
