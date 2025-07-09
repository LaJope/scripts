#!/usr/bin/env nu

def main [
  --raw (-r) # Output plain text
] {
  let xraw = xrandr | grep " connected"
  let monitors = $xraw | split row "\n" | each {|mon_info|
    let prim = try {let _ = $mon_info | grep "primary"; true} catch {false};
    let sp = if $prim {
      $mon_info | split row " " | get 0 3;
    } else {
      $mon_info | split row " " | get 0 2;
    }
    let res_info = $sp.1 | str substring ..(($sp.1 | str index-of "+") - 1);
    {name: $sp.0, resolution: $res_info}
  }
  if $raw {
    return ($monitors | to text | str trim)
  }
  return ($monitors | to nuon)
}
