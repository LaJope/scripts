if [[ $(pgrep vlc) == '' ]]; then
  feh --bg-fill ~/.custom/JTTOU/Just_The_Two_Of_Us.png
  cvlc --qt-start-minimized ~/.custom/JTTOU/Just_The_Two_Of_Us.mp3
else
  killall vlc
fi
