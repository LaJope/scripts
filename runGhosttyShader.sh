#!/bin/bash

if [ "$#" == 0 ]; then
  echo "Not enough arguments. Exiting"
  exit 1
fi

shaderFolder="$HOME/.config/ghostty/shaders"
launchCommand="ghostty"
shaderFlag="--custom-shader="

flag=$1
if [ "$flag" = "--random" ]; then
  randomShader=$(find "$shaderFolder" | shuf -n 1)
  $launchCommand "$shaderFlag$randomShader"
  exit 0
fi

for var in "$@"
do
  shaderPath=$(find "$shaderFolder/$var")
  [ "$shaderPath" != "" ] || { echo "Exiting"; exit 1; }
  launchCommand="$launchCommand $shaderFlag$shaderPath"
done

$launchCommand
