#!/usr/bin/env nu

def main [
  message: string
  monitors?: string
] {
  let opts = if $monitors == null {
    getMonitors.nu
  } else {
    $monitors
  } | from nuon | get name | to nuon

  let width = 10

  let sel = try {
    dmenuSelect.nu $opts $message --width=($width)
  } catch {
    exit 1
  }

  return $sel
}
