#!/usr/bin/env nu

let shader_folder = "/home/lajope/.config/ghostty/shaders/"
let shader_flag = " --custom-shader="

let shaders = ["in-game-crt", "retro-terminal", "starfield",
  "starfield-colors", "retro-terminal in-game-crt", "random"]

let opts = $shaders | to nuon

let width = 20
let msg = "Shader"

let sel = try {
  dmenuSelect.nu $opts $msg --fuzzy --width=($width)
} catch {
  exit 0
}

mut launchCommand = "ghostty"

if $sel == "random" {
  let shader_path = (ls $shader_folder | shuffle | get 0.name)
  $launchCommand += $shader_flag + $shader_path
} else {
  for $shader in ($sel | split row " ") {
    let shader_path = $shader_folder + $shader + ".glsl"
    if not ($shader_path | path exists) {
      rofi -e "No shader file " + $shader ; exit 1
    }
    $launchCommand += $shader_flag + $shader_path
  }
}

nu -c $launchCommand
