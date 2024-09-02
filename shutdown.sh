#!/bin/bash

printf "1 - shutdown\n2 - restart\nChoose: "

input=""
read -r input

case "$input" in
  "1") shutdown -h now ;;
  "2") shutdown -h now -r ;;
  "*") printf "Unexpected input\n" ;;
esac
