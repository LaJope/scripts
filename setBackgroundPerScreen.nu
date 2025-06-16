#!/usr/bin/env nu

let mon_nuon = getMonitors.nu
let monitors = $mon_nuon | from nuon

let msg = "Monitor"
let mon = try { selectMonitor.nu $msg $mon_nuon -c } catch { exit 0 }

let monitor_id = $monitors.name | enumerate | where item == $mon | get 0.index | into int

setBackground.nu --monitor=($monitor_id)
