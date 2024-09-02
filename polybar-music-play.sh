#!/bin/bash

player='chromium'

if [[ $(playerctl --player=$player status 2>&1) == 'Playing' ]];
  then
    echo '  '
  else
    echo '  '
fi

