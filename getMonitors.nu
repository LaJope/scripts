#!/usr/bin/env nu

# let testing = "Monitors: 1\n 0: +*eDP-1 1920/381x1080/214+0+0  eDP-1\n 0: +*HDMI-1-0 1920/381x1080/214+0+0  HDMI-1-0"

def main [
  --raw (-r)
] {
  # let xraw = $testing
  let xraw = xrandr | grep " connected"
  # let xraw = (xrandr --listmonitors)
  let monitors = $xraw | split row "\n" | each {|mon_info|
    let sp = $mon_info | split row " " | get 0 3;
    let res_info = $sp.1 | str substring ..(($sp.1 | str index-of "+") - 1);
    {name: $sp.0, resolution: $res_info}
  }
  if $raw {
    return ($monitors | to text | str trim)
  }
  return ($monitors | to nuon)
}
