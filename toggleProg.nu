#!/usr/bin/env nu

def --wrapped main [
  --is_running (-r)
  --cust_exec (-c): string
  program: string
  ...arguments: string
] {
  let status = try { let tmp = pgrep $program ; true } catch { false }

  if $is_running {
    print ($status | into int)
    exit 0
  }

  if $status {
    killall $program
  } else {
    let exec = if $cust_exec == null { $program } else { $cust_exec }
    ^$exec ...$arguments
  }
}
