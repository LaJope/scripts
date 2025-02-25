if [[ $(pgrep screenkey) == '' ]]; then
  screenkey
else
  killall screenkey
fi
