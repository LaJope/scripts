#!/usr/bin/env nu

let variants = ["No", "Yes"]
let opts = $variants | to nuon
const width = 10

def main [selection?: string] {
  let msg = "You sure?" + (
    if $selection == null { "" } else { "\n" + $selection }
  )

  let sel = try {
    dmenuSelect.nu $opts $msg --width=($width)
  } catch {
    exit 0
  }

  return ($sel == "Yes")
}
