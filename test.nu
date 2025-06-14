#!/usr/bin/env nu

def main [--he (-h)] {
  if $he {
    rofi -e hello
  } else {
    rofi -e bye
  }
}
