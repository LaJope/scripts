#!/usr/bin/env nu

let sinks = (pactl -f json list sinks | from json | select name description)
let options = $sinks | get description | to nuon

let width = 20
let msg = "Audio"

let sel = try {
  dmenuSelect.nu $options $msg --width=($width)
} catch {
  exit 0
}

let sink_name = ($sinks | where description == $sel | get name | to text)

pactl set-default-sink ($sink_name | str trim)
