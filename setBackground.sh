#!/bin/bash

bgFolder="$HOME/HDD/Backgrounds/"

if [ "$#" != 1 ]; then
  echo "Need one argument";
  exit 1;
fi


currFolder=""

case $1 in
  "public") currFolder="$bgFolder/pub" ;;
  "private") currFolder="$bgFolder/priv" ;;
  "all") currFolder="$bgFolder" ;;
  "*") currFolder="$bgFolder" ;;
esac

if [[ $(pgrep feh) ]]; then
  killall feh
fi

feh --bg-fill --recursive --randomize "$currFolder"
