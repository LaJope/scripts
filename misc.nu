#!/usr/bin/env nu

let scripts = [
  [name, path];
  ["Kill", "killprompt.nu"],
  ["Audio", "switchAudioOutput.nu"],
  ["Ghostty shaders", "runGhosttyShader.nu"],
  ["Duplicate monitor", "duplicateMonitor.nu"],
  ["Rotate monitor", "rotateMonitor.nu"]
  ["Background", "setBackground.nu"]
  ["Shutdown", "shutdown.nu"],
]

let opts = $scripts | get name | to nuon

let width = 20
let msg = "Script"

let sel = try {
  dmenuSelect.nu $opts $msg --fuzzy --width=($width)
} catch {
  exit 0
}

let scr = $scripts | where name == $sel | get path | str trim

^($scr)
