#!/usr/bin/env nu

let bgFolder = "/home/lajope/HDD/Backgrounds/"

let variants = [
  [type, folder];
  ["public",  ($bgFolder + "pub/")],
  ["private", ($bgFolder + "priv/")],
  ["all",      $bgFolder]
]

def main [type: string] {
  let folder = try {
    $variants | where type == $type | get 0.folder
  } catch {
    exit 0
  }
  feh --bg-fill --recursive --randomize $folder
}
