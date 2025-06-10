#!/usr/bin/env nu

let dir = "/home/lajope/.custom/scripts"

let sinks = (pactl -f json list sinks | from json | select name description)
let options = ($sinks | get description | enumerate |
               format pattern "{index} {item}" | to text)

let len = ($sinks | length)
let width = 20
let msg = "Audio"

let sel = try {
  nu ($dir + "/dmenuSelect.nu") $options $len $msg --width=($width)
} catch {
  exit 0
}

let sink_name = ($sinks | where description == $sel | get name | to text)

pactl set-default-sink ($sink_name | str trim)
