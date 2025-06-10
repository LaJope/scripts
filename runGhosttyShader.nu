#!/usr/bin/env nu

let shader_folder = "$HOME/.config/ghostty/shaders"
let shader_flag = "--custom-shader="
let shaders = ["in-game-crt", "retro-terminal", "starfield",
  "starfield-colors", "retro-terminal in-game-crt", "random", "cancel"]
let len = ($shaders | length)
let theme_rofi = "window {width: 25%;}"

def main [] {
  mut launch_command = "ghostty"

}
