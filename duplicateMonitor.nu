#!/usr/bin/env nu

let mon_nuon = getMonitors.nu
let monitors = $mon_nuon | from nuon

let disconnect = {
  let msg = "Disconnect"
  let ext = try { selectMonitor.nu $msg $mon_nuon } catch { exit 0 }
  xrandr --output $ext --off
}

let extra = {
  let msg = "Primary"
  let pri = try { selectMonitor.nu $msg $mon_nuon } catch { exit 0 }

  let mon_nuon = $monitors | where name != $pri | to nuon
  let msg = "Secondary"
  let ext = try { selectMonitor.nu $msg $mon_nuon } catch { exit 0 }

  let res = try {
    $monitors | where name == $ext | get 0.resolution
  } catch {
    exit 0
  }
  xrandr --output $pri --primary --output $ext --mode $res --right-of $pri
}

let duplicate = {
  let msg = "Primary"
  let pri = try { selectMonitor.nu $msg $mon_nuon } catch { exit 0 }

  let mon_nuon = $monitors | where name != $pri | to nuon
  let msg = "Secondary"
  let ext = try { selectMonitor.nu $msg $mon_nuon } catch { exit 0 }

  let res = try {
    $monitors | where name == $ext | get 0.resolution
  } catch {
    exit 0
  }
  xrandr --output $pri --primary --output $ext --mode $res --same-as $pri
}

let variants = [
  [ type, function ];
  ["disconnect", $disconnect],
  ["extra to the right", $extra],
  ["duplicate", $duplicate]
]

let opts = $variants | get type | to nuon

let width = 20
let msg = "Monitor"

let sel = try {
  dmenuSelect.nu $opts $msg --width=($width)
} catch {
  exit 0
}

do ($variants | where type == $sel | get 0.function)
