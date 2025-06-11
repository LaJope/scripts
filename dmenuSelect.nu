#!/usr/bin/env nu

def main [
  opts: string
  len: int
  msg: string
  --theme (-t): string
  --width (-w): int
] {
  let options = ($opts | from nuon | enumerate |
                 format pattern "{index} {item}" | to text)
  mut th = ""
  if $theme == null {
    $th = "window {width: " + (
            if $width == null { 40 } else { $width } | to text
          ) + "%;}"
  }

  try {
    let tmp = ($options | rofi -dmenu -theme-str $th -i -l $len -c -p $msg)
    let idx = $tmp | str index-of " "
    return ($tmp | str substring ($idx + 1)..)
  } catch {
    exit 1
  }
}
