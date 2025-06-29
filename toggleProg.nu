#!/usr/bin/env nu

def --wrapped main [
  --help (-h)
  --is_running (-r)         # Print 1/0 if the program does/doesn't run
  --cust_exec (-c): string  # Specify custom executable to run if program is not running
  program: string           # Specify program name
  ...arguments: string      # Flags for program launch
] {
  if $help {
    help main
    return
  }

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
