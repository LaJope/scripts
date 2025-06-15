#!/usr/bin/env nu

# let testing = "Monitors: 1\n 0: +*eDP-1 1920/381x1080/214+0+0  eDP-1\n 0: +*HDMI-1-0 1920/381x1080/214+0+0  HDMI-1-0"

def main [
  --raw (-r)
] {
# let xraw = $testing
  let xraw = (xrandr --listmonitors)
  let monitors = $xraw | split row "\n" | drop nth 0 | each {|mon_info|
    let sp = $mon_info | split row " " | get 3 5;
    let res_info = $sp.0 | split row "x";
    let width = $res_info.0 | split row "/" | get 0;
    let height = $res_info.1 | split row "/" | get 0;
    {name: $sp.1, resolution: ($width + "x" + $height)}
  }
  if $raw {
    return ($monitors | to text | str trim)
  }
  return ($monitors | to nuon)
}
