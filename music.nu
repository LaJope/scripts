#!/usr/bin/env nu

def getMusic [player: string] {
  mut music: record = {}
  for $meta in [title, artist] {
    let data = (playerctl --player=($player) metadata xesam:($meta))
    $music = $music | merge {$meta: ($data | iconv -f utf-8 -t ascii//TRANSLIT)
    }
  }
  return $music
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

def format_music [music: record] {
  printf "%s (%s)" $music.title $music.artist
}

def rotate_title [
  mus: record
  --max_len (-l): int
  --speed (-s): int
] {
  mut MAX_LEN = if $max_len == null { 44 } else { $max_len }
  mut SPEED = if $speed == null { 1 } else { $speed }

  let full_len = ($mus.title | str length) + ($mus.artist | str length) + 3

  if $full_len <= $MAX_LEN {
    format_music $mus
    exit 0
  }

  let music = {
    title: $"($mus.title)  ",
    artist: $" \(($mus.artist)\)"
  }

  let t_len = ($music.title | str length)
  let a_len = ($music.artist | str length)

  let rotate_str = if $a_len - 1 >= $MAX_LEN {
    $"($music.title)($music.artist)"
  } else {
    $music.title
  }
  let fixed_str = if $a_len - 1 >= $MAX_LEN {
    ""
  } else {
    $MAX_LEN -= $a_len;
    $music.artist
  }

  let rotate_len = $rotate_str | str length

  let time = (date now | format date "%s" | into int) * $SPEED
  let display_pos = $time mod $rotate_len

  let display_str = if $display_pos + $MAX_LEN > $rotate_len {
    let first_part = $rotate_str | str substring ($display_pos)..;
    let rest_char = $MAX_LEN - ($first_part | str length) - 1;
    let second_part = $rotate_str | str substring ..($rest_char);
    $"($first_part)($second_part)"
  } else {
    $rotate_str | str substring ($display_pos)..($display_pos + $MAX_LEN - 1)
  }

  printf "%s%s" $display_str $fixed_str
}

def main [
  --player  (-p): string # Specify player 
  --format  (-f)         # Output is formated "title (artist)" instead of nuon
  --title   (-t)         # Output title
  --artist  (-a)         # Output artist
  --rotate  (-r)         # Rotate title (with max_len and speed)
  --max_len (-l): int    # Max length of rotated title
  --speed   (-s): int    # Speed of rotation
] {
  mut music: record = {}
  let on: bool = try {
    let check = ["Playing"]; # "Paused"
    (playerctl --player=($player) status | complete |
    get stdout | str trim) in $check
  } catch {
    false
  }
  if $player != null and $on {
    $music = (getMusic $player)
  } else {
    $music = (otherPlayers)
  }
  try {
    if $rotate {
      rotate_title $music --max_len=($max_len) --speed=($speed)
    } else if $title {
      print $music.title
    } else if $artist {
      print $music.artist
    } else if $format {
      format_music $music
    } else {
      return ($music | to nuon)
    }
  } catch {
    print ""
  }
}
