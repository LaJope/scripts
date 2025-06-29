#!/usr/bin/env nu

let variants = ["No", "Yes"]
let opts = $variants | to nuon
const width = 10

const MAX_LEN = 12

def main [
  selection?: string  # Prints what user previously selected. Just for looks
] {
  let msg = "You sure?" + ( if $selection == null { "" } else {
      "\n" + ($selection | str substring ..($MAX_LEN)) })

  let sel = try {
    dmenuSelect.nu $opts $msg --width=($width)
  } catch {
    exit 0
  }

  return ($sel == "Yes")
}
