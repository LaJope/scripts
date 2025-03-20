#!/bin/bash


is_active=$(pgrep feh)
pubFolder="$HOME/HDD/Backgrounds/pub/"
privFolder="$HOME/HDD/Backgrounds/priv/"
allFolder="$HOME/HDD/Backgrounds/"

if [ "$#" != 1 ]; then
  echo "Need one argument";
  exit 1;
fi


bgFolder="$pubFolder"

case $1 in
  "public") bgFolder="$pubFolder" ;;
  "private") bgFolder="$privFolder" ;;
  "all") bgFolder="$allFolder" ;;
esac

if [[ $is_active != '' ]]; then
  killall feh
fi

feh --bg-fill --recursive --randomize "$bgFolder"
