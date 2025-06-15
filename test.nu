#!/usr/bin/env nu


def main [
  --mon (-m): int
] {
  if $mon != null {
    print $mon
  } else {
    print Hello
  }
}
