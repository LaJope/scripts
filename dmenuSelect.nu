#!/usr/bin/env nu

def main [
  options: string       # List of string (nuon format) to select from
  msg: string           # Prompt to display
  --fuzzy (-f)          # Use fuzzy matching
  --theme (-t): string  # rofi -dmenu theme (default sets width)
  --width (-w): int     # width form theme
  --length (-l): int    # Number of lines to display (default options length)
] {
  let opts = try {
    $options | from nuon | enumerate |
      format pattern "{index} {item}" | to text
  } catch {
    $options
  }
  let len = if $length == null {$options | from nuon | length} else {$length}
  let th = "window {width: " + ($width | to text) + "%;}"

  try {
    let selection = $opts | (
      if $fuzzy {
        rofi -matching fuzzy -dmenu -theme-str $th -i -l $len -c -p $msg
      } else {
        rofi -dmenu -theme-str $th -i -l $len -c -p $msg
      }
    )
    let idx = $selection | str index-of " "
    return ($selection | str substring ($idx + 1)..)
  } catch {
    exit 1
  }
}
