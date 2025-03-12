#!/usr/bin/env bash

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
  create_wallpaper_list
# Read wallpaper list into an array
# wallpapers=()
# while IFS= read -r line; do
#     wallpapers+=("$line")
# done < "$wallpaper_list_file"
readarray -t wallpapers < "$wallpaper_list_file"
# Infinite loop for changing wallpapers
while true; do
  log "Selecting wallpapers randomly..."

  # Select 3 unique random wallpapers from the array
  mapfile -t selected_wallpapers < <(shuf -e "${wallpapers[@]}" -n 3)
  #
  wallpaper1="${selected_wallpapers[0]}"
  # wallpaper2="${selected_wallpapers[1]}"
  # wallpaper3="${selected_wallpapers[2]}"
  #
  log "Wallpapers selected:"
  log "Wallpaper1: $wallpaper1"
  # log "Wallpaper2: $wallpaper2"
  # log "Wallpaper3: $wallpaper3"

  # Assign same wallpaper to all monitors
    hyprctl hyprpaper reload ",$wallpaper1"
  # Assign different wallpapers to attached monitors
  # i=0
  # for monitor in $(hyprctl monitors | grep 'Monitor' | awk '{ print $2 }'); do
  #     wallpaper_path="${selected_wallpapers[$i]}"
  #
  #     if [[ -f "$wallpaper_path" ]]; then
  #
  #         hyprctl hyprpaper reload "$monitor,$wallpaper_path"
  #     else
  #         log "Error: Wallpaper file '$wallpaper_path' does not exist for monitor $monitor."
  #     fi
  #
  #     ((i++))
  #     if [[ $i -ge ${#selected_wallpapers[@]} ]]; then
  #         i=0  # Loop back if there are more monitors than selected wallpapers
  #     fi
  # done

  duration=333
  log "Sleeping for $duration seconds..."
  sleep $duration
done
