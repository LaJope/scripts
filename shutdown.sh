#!/bin/bash

array=("shutdown" "restart");
PS3="Choose: ";

select input in "${array[@]}"; do
  case "$input" in
    "shutdown") shutdown -h now ;;
    "restart") shutdown -h now -r ;;
  esac
  break;
done
