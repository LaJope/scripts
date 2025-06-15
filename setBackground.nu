#!/usr/bin/env nu

let bgFolder = "/home/lajope/HDD/Backgrounds/"

let variants = [
  [type, folder];
  ["public",    ($bgFolder + "public")],
  ["private",   ($bgFolder + "private")],
  ["minecraft", ($bgFolder + "minecraft")],
  ["all",        $bgFolder],
]
let opts = $variants | get type | to nuon
let width = 20
let msg = "Background"

def setBg [type: string] {
  try {
    let folder = $variants | where type == $type | get 0.folder
    feh --bg-fill --recursive --randomize $folder
  } catch {}
}

def main [type?: string] {
  if $type != null and $type in ($variants | get type) {
    setBg $type
    exit 0
  }

  try {
    let sel = dmenuSelect.nu $opts $msg --fuzzy --width=($width)
    setBg $sel
  } catch {
    exit 0
  }

  setBackground.nu
}
