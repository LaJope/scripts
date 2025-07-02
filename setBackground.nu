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
  type?: string
  --file (-f): string
  --monitor (-m): int
  --wallust (-w)
] {
  let folder = if $file == null {
    $variants | where type == $type | get 0.folder
  } else {
    $file
  }

  if $monitor == null {
    feh --bg-fill --recursive --randomize $folder
  } else {
    feh --bg-fill --recursive --randomize $folder --xinerama-index $monitor
  }

}

def changeColorscheme [] {
  print hello
  let bg = cat ~/.fehbg |
    split row "\n" | drop nth 0 | split row " " | get 3 |
    str replace --all "\'" ""
  print $bg
  wallust run $bg -s
}

def tmp [
  type?: string        # Type of background folder to randomize
  --file (-f): string  # Specify file to set background to. Ignores type
  --monitor (-m): int  # Specify monitor id
  --per_mon (-p)       # Pick monitor and background for it (hopefully works. Cannot check. No second monitor :( )
] {
  if $file != null {
    let path = try { ls $file ; $file } catch { $bgFolder + $file }
    setBg --file=($path) --monitor=($monitor)
    return
  }

  if $per_mon {
    perMonitor
    return
  }

  if $type != null and $type in ($variants | get type) {
    setBg $type --monitor=($monitor) 
    return
  }

  while true {
    try {
      let sel = dmenuSelect.nu $opts $msg --width=($width) --length=($len - 1)
      setBg $sel --monitor=($monitor) 
    } catch {
      return
    }
  }
}

def main [
  type?: string        # Type of background folder to randomize
  --file (-f): string  # Specify file to set background to. Ignores type
  --monitor (-m): int  # Specify monitor id
  --per_mon (-p)       # Pick monitor and background for it (hopefully works. Cannot check. No second monitor :( )
  --wallust (-w)       # Use wallust to change theme
] {
  tmp $type --file=($file) --monitor=($monitor) --per_mon=($per_mon)
  if $wallust {
    changeColorscheme
  }
}
