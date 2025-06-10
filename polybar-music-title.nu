#!/usr/bin/env nu

def getMusic [player: string] {
  mut data: record = {}
  for $meta in [title, artist] {
    let metadata = (playerctl --player=($player) metadata xesam:($meta))
    $data = $data | merge {$meta: $metadata}
  }
  return $data
}

def otherPlayers [] {
  let fon: bool = (
    playerctl --player=firefox status | complete | get stdout | str trim
  ) == "Playing"
  let fsi: bool = (
    playerctl --player=firefox metadata | complete | get stdout
  ) | str contains "music.yandex"
  let fvlc: bool = try { pgrep vlc } catch { false }
  mut music: record = {}
  if $fvlc == true {
    $music = (getMusic vlc)
  } else if $fon == true and $fsi == true {
    $music = (getMusic firefox)
  }
  return $music
}

def main [
  player?: string
  --format (-f)
] {
  mut music: record = {}
  let on: bool = try {
    (playerctl --player=($player) status | complete |
    get stdout | str trim) == "Playing"
  } catch {
    false
  }
  if $player != null and $on {
    $music = (getMusic $player)
  } else {
    $music = (otherPlayers)
  }
  try {
    if $format {
      printf "%s (%s)" $music.title $music.artist
    } else {
      return ($music | to nuon)
      # return $music
    }
  } catch {
    print ""
  }
}
