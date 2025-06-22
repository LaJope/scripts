#!/usr/bin/env nu

def --wrapped main [
  --cust_exec (-c): string
  program: string
  ...arguments: string
] {
  let status = try { let tmp = pgrep $program ; true } catch { false }

  if $status {
    killall $program
  } else {
    let exec = if $cust_exec == null { $program } else { $cust_exec }
    ^$exec ...$arguments
  }
}
