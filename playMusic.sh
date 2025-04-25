#!/bin/bash

shopt -s dotglob
shopt -s nullglob

music_folder="$HOME/Music/*"

# playlists=(~/Music/*)
playlists=($music_folder)

PS3="Which playlist do you want to play? "

echo "There are ${#playlists[@]} dirs in the current path";
select dir in "${playlists[@]}"; do
  vlc "$dir" --daemon;
  break;
done
