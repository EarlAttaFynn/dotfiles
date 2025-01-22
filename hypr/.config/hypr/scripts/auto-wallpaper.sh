#!/bin/sh

# Start logging
log_dir="/tmp/auto-wallpaper"
log_file="${log_dir}/auto-wallpaper_$(date '+%Y-%m-%d_%H-%M-%S').log"

# Ensure log directory exists
mkdir -p "$log_dir"
exec > >(tee -a "$log_file") 2>&1

log() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}

log "Starting auto-wallpaper script..."

# Path to wallpapers
wallpaper_dir="$HOME/Pictures/wallpaper"
wallpaper_list_file="/tmp/auto-wallpaper/wallpaper_list.txt"
wallpaper_dir_timestamp_file="/tmp/auto-wallpaper/wallpaper_dir_timestamp.txt"

# Validate directory
if [ ! -d "$wallpaper_dir" ]; then
  log "Error: Wallpaper directory '$wallpaper_dir' does not exist."
  exit 1
fi

# Function to create and cache wallpaper list
create_wallpaper_list() {
  log "Creating and caching wallpaper list..."
  # Find and shuffle the wallpaper files
  find -L "$wallpaper_dir" -type f | shuf > "$wallpaper_list_file"
}

# Check if the directory has changed since last cached
if [ ! -f "$wallpaper_list_file" ] || [ ! -f "$wallpaper_dir_timestamp_file" ] || [ "$(stat -c %Y "$wallpaper_dir")" -gt "$(cat "$wallpaper_dir_timestamp_file")" ]; then
  # Create or update the list if directory has changed
  create_wallpaper_list
  # Update the timestamp file with the current time of the wallpaper directory
  stat -c %Y "$wallpaper_dir" > "$wallpaper_dir_timestamp_file"
else
  log "Using cached wallpaper list from '$wallpaper_list_file'."
fi

# Infinite loop for changing wallpapers
while true; do
  log "Selecting wallpapers randomly..."

  # Read the wallpaper list from the file
  wallpapers=$(shuf "$wallpaper_list_file")

  # Split shuffled list into unique groups
  wallpaper1=$(echo "$wallpapers" | head -n 3 | tr '\n' ',' | sed 's/,$//')
  wallpaper2=$(echo "$wallpapers" | head -n 6 | tail -n 3 | tr '\n' ',' | sed 's/,$//')
  wallpaper3=$(echo "$wallpapers" | head -n 9 | tail -n 3 | tr '\n' ',' | sed 's/,$//')

  log "Wallpapers selected:"
  log "Wallpaper1: $wallpaper1"
  log "Wallpaper2: $wallpaper2"
  log "Wallpaper3: $wallpaper3"

  # Preload wallpapers with hyprctl
  log "Preloading wallpapers with hyprctl..."
  hyprctl hyprpaper preload "$wallpaper1" 2>&1 | tee -a "$log_file"
  hyprctl hyprpaper preload "$wallpaper2" 2>&1 | tee -a "$log_file"
  hyprctl hyprpaper preload "$wallpaper3" 2>&1 | tee -a "$log_file"

  # Set wallpapers to outputs
  log "Setting wallpapers to outputs..."
  hyprctl hyprpaper wallpaper "eDP-1,$wallpaper1" 2>&1 | tee -a "$log_file"
  hyprctl hyprpaper wallpaper "DP-2,$wallpaper2" 2>&1 | tee -a "$log_file"
  hyprctl hyprpaper wallpaper "HDMI-A-1,$wallpaper3" 2>&1 | tee -a "$log_file"

  log "Sleeping for 36 seconds..."
  sleep 36
done
