#!/usr/bin/env nu

const bgFolder = "/home/lajope/HDD/Backgrounds/"

let variants = [
  [type, folder];
  ["favourite", ($bgFolder + "favourite")],
  ["public",    ($bgFolder + "public")],
  ["private",   ($bgFolder + "private")],
  ["minecraft", ($bgFolder + "minecraft")],
  ["all",        $bgFolder],
  [" ",         ($bgFolder + ".private")],
]
let opts = $variants | get type | to nuon
const width = 20
const msg = "Background"
let len = $variants | length

def setBg [
  type: string
  monitor?: int
] {
  let folder = $variants | where type == $type | get 0.folder

  if $monitor == null {
    feh --bg-fill --recursive --randomize $folder
  } else {
    feh --bg-fill --recursive --randomize $folder --xinerama-index $monitor
  }
}

def main [
  type?: string
  --monitor (-m): int
] {
  if $type != null and $type in ($variants | get type) {
    setBg $type $monitor
    exit 0
  }

  while true {
    try {
      let sel = dmenuSelect.nu $opts $msg --width=($width) --length=($len - 1)
      setBg $sel $monitor
    } catch {
      exit 0
    }
  }
}
