#!/bin/bash

panicBrightness=30
normalBrightness=7500

curr=$(brightnessctl get)

if [ "$curr" != $panicBrightness ] ; then
    brightnessctl set $panicBrightness ;
else
    brightnessctl set $normalBrightness;
fi
