#!/bin/zsh

shaderFolder="$HOME/.config/ghostty/shaders"
launchCommand="ghostty"
shaderFlag="--custom-shader="

shaders=("in-game-crt" "retro-terminal" "starfield" "starfield-colors"
  "retro-terminal in-game-crt" "random" "cancel");

for ((i = 1; i <= $#shaders; i++))
  shadersEnum[i]="$i "$shaders[i]

length="${#shaders[@]}"
theme_rofi="window {width: 25%;}"

prompt="${(j:\n:)shadersEnum}"
message="Shader"

select_rofi=$(echo "$prompt" | \
  rofi -matching fuzzy -dmenu -l "$length" -i -theme-str "$theme_rofi" -p "$message")
index=$(echo $select_rofi | awk '{print $1}')
input=$shaders[$index]

if [ $input = "random" ]; then
  randomShaderPath=$(find "$shaderFolder" | shuf -n 1)
  launchCommand="$launchCommand $shaderFlag$randomShaderPath"
else
  for var in "${(s: :)input}"; do
    shaderPath=$(find "$shaderFolder/$var.glsl")
    [ "$shaderPath" != "" ] || { echo "Exiting"; exit 1; }
    launchCommand="$launchCommand $shaderFlag$shaderPath"
  done
fi

eval ${launchCommand}
