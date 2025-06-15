#!/usr/bin/env nu

def main [
  message: string
  monitors?: string
  --confirm (-c)
  --skip (-s)
] {
  let mon = if $monitors == null {
    getMonitors.nu
  } else {
    $monitors
  } | from nuon

  let len = $mon | length

  if $len == 0 { exit 1 }

  if not $skip {
    if $len == 1 {
      let var = $mon.name.0
      if $confirm {
        return $var
      }
      if (youSure.nu $var) == "true" {
        return $var
      } else {
        exit 1
      }
    }
  }

  let opts = $mon | get name | to nuon

  let width = 10

  let sel = try {
    dmenuSelect.nu $opts $message --width=($width)
  } catch {
    exit 1
  }

  return $sel
}
