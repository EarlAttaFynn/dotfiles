#!/bin/sh
while true; do
    wallpaper1="$(find -L "$HOME/Pictures/wallpaper" -type f | shuf -n 3)"
    wallpaper2="$(find -L "$HOME/Pictures/wallpaper" -type f | shuf -n 6)"
    wallpaper3="$(find -L "$HOME/Pictures/wallpaper" -type f | shuf -n 9)"

    hyprctl hyprpaper preload "$wallpaper1"
    hyprctl hyprpaper wallpaper "eDP-1,$wallpaper" &

    hyprctl hyprpaper preload "$wallpaper"
    hyprctl hyprpaper wallpaper "DP-2,$wallpaper" &

    hyprctl hyprpaper preload "$wallpaper"
    hyprctl hyprpaper wallpaper "HDMI-A-1,$wallpaper" &

    sleep 12
done
