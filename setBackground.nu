#!/usr/bin/env nu

const bgFolder = "/home/lajope/HDD/Backgrounds/"

let visible = ls $bgFolder | each {|dir|
  let name = $dir.name | str replace $bgFolder "";
  {type: $name, folder: $dir.name}
}

let pre = [
  [type, folder];
  ["all",        $bgFolder],
  [" ",         ($bgFolder + ".private")],
]

let variants = $visible | append $pre


let opts = $variants | get type | to nuon
const width = 20
const msg = "Background"
let len = $variants | length

def perMonitor [] {
  let mon_nuon = getMonitors.nu
  let monitors = $mon_nuon | from nuon

  let msg = "Monitor"
  let mon = try { selectMonitor.nu $msg $mon_nuon -c } catch { exit 0 }

  let monitor_id = $monitors.name | enumerate |
    where item == $mon | get 0.index | into int

  main --monitor=($monitor_id)
}

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
  --file (-f): string
  --monitor (-m): int
  --per_mon (-p)
] {
  if $file != null {
    let path = try { ls $file ; $file } catch { $bgFolder + $file }
    feh --bg-fill $path
    exit 0
  }

  if $per_mon {
    perMonitor
    exit 0
  }

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
