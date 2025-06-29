#!/usr/bin/env nu

def scroll-text [text: string, width: int = 10, delay: int = 2000] {
  loop {
    let len = ($text | str length)
    for $pos in 0..$len {
      let end_pos = ([($pos + $width), $len] | math min)
      let segment = ($text | str substring $pos..$end_pos)
      print -n $"\r($segment)"
    }
  }
}
scroll-text "This is a scrolling text in Nushell!"
