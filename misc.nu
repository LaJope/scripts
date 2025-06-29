#!/usr/bin/env nu

let scripts = [
  [name, path, priority];
  ["Kill",            "killprompt.nu",        1],
  ["Audio",           "switchAudioOutput.nu", 1],
  ["Notes",           "newNote.nu",           1],
  ["Background",      "setBackground.nu",     1],
  ["Shutdown",        "shutdown.nu",          1],
  ["Next",           ["misc.nu", "-p", "2"],  1]

  ["Duplicate monitor",      "monitorDuplicate.nu",       2],
  ["Rotate monitor",         "monitorRotate.nu",          2],
  ["Background per screen", ["setBackground.nu", "-p"],   2],
  ["Ghostty shaders",        "runGhosttyShader.nu",       2],
]

def main [
  --priority (-p): int # Defines which scripts will be shown
] {
  let opts = $scripts | where priority == $priority | get name | to nuon

  let width = 20
  let msg = "Script"

  let sel = try {
    dmenuSelect.nu $opts $msg --fuzzy --width=($width)
  } catch {
    exit 0
  }

  let scr = $scripts | where name == $sel | get 0.path

  ^($scr)
}
