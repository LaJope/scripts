#!/bin/bash

is_active=$(pgrep vlc)
JTbg="$HOME/.custom/JTTOU/Just_The_Two_Of_Us.png"
JTmus="$HOME/.custom/JTTOU/Just_The_Two_Of_Us.mp3"

bgfolder="$HOME/Desktop/Good Backgrounds/"

if [[ $is_active = '' ]]; then
  feh --bg-fill "$JTbg"
  cvlc --qt-start-minimized "$JTmus"
else
  feh --bg-fill --randomize "$bgfolder"
  killall vlc
fi
