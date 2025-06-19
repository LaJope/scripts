#!/usr/bin/env nu

let folder = "/home/lajope/Notes"

let width = 20

def openNote [name: string] {
  ^(setsid -f "ghostty" -e nvim ($folder + "/" + $name)) o+e | ignore
}

def newNote [] {
  let th = "window {width: " + ($width | to text) + "%;}"
  let msg = "Name"

  mut name = (rofi -dmenu -theme-str $th -l 0 -c -p $msg)
  if $name == "" {
    $name = (/bin/date +%F_%T | tr ':' '-')
  }
  openNote ($name + ".md")
}

let new = ["New"]

let old = ls $folder | sort-by name |
  each {|file| $file.name | str replace ($folder + "/") ""}

let variants = $new | append $old

let opts = $variants | to nuon

let msg = "New or create"
let len = [($variants | length), 10] | math min

let sel = try {
  dmenuSelect.nu $opts $msg --fuzzy --width=($width) --length=($len)
} catch {
  exit 0
}

match $sel {
  "New" => { newNote },
  _ => { openNote $sel }
}
