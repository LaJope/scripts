#!/usr/bin/env nu

const bgFolder = "/home/lajope/HDD/Backgrounds/"

let variants = [
  [type, folder];
  ["favourite", ($bgFolder + "favourite")],
  ["public",    ($bgFolder + "public")],
  ["private",   ($bgFolder + "private")],
  ["minecraft", ($bgFolder + "minecraft")],
  ["all",        $bgFolder],
]
let opts = $variants | get type | to nuon
const width = 20
const msg = "Background"

def setBg [
  type: string
  monitor_id: int
] {
  try {
    let folder = $variants | where type == $type | get 0.folder
    feh --bg-fill --recursive --randomize $folder --xinerama-index $monitor_id
  } catch {}
}

def main [
  type?: string
  --monitor (-m): int
] {
  let $monitor_id = if $monitor != null { $monitor } else { 0 }
  if $type != null and $type in ($variants | get type) {
    setBg $type $monitor_id
    exit 0
  }

  while true {
    try {
      let sel = dmenuSelect.nu $opts $msg --fuzzy --width=($width)
      setBg $sel $monitor_id
    } catch {
      exit 0
    }
  }
}
