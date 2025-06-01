#!/bin/bash

array=("shutdown" "restart" "cancel");
PS3="Choose: ";

select input in "${array[@]}"; do
  case "$input" in
    "shutdown") shutdown -h now ;;
    "restart") shutdown -h now -r ;;
    "cancel") exit 0 ;;
  esac
  break;
done
