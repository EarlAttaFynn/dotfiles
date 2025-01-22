#!/bin/bash

# Start logging
log_dir="/tmp/reload-hyprpaper"
log_file="${log_dir}/reload-hyprpaper_$(date '+%Y-%m-%d_%H-%M-%S').log"

# Ensure log directory exists
mkdir -p "$log_dir"
exec > >(tee -a "$log_file") 2>&1

log() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}

log "Starting script: $(basename "$0")"

# Kill any other instances of this script
script_name=$(basename "$0")
pids=$(pgrep -f "$script_name")

log "Checking for other instances of the script..."
current_pid=$$
for pid in $pids; do
  if [ "$pid" != "$current_pid" ]; then
    log "Found another instance running with PID $pid. Killing it."
    kill -9 "$pid" >/dev/null 2>&1
  fi
done

# Kill any running hyprpaper processes
log "Killing any existing hyprpaper processes..."
killall hyprpaper >/dev/null 2>&1
sleep 1

# Create timestamp for log files
timestamp=$(date '+%Y-%m-%d_%H-%M-%S')
log "Timestamp for this run: $timestamp"

# Log file directories
hyprpaper_dir="/tmp/hyprpaper"
auto_wallpaper_dir="/tmp/auto-wallpaper"

# Ensure log directories exist
log "Ensuring log directories exist..."
mkdir -p "$hyprpaper_dir" "$auto_wallpaper_dir"

# Log files
hyprpaper_log="${hyprpaper_dir}/hyprpaper_${timestamp}.log"
auto_wallpaper_log="${auto_wallpaper_dir}/auto-wallpaper_${timestamp}.log"
log "Log files: $hyprpaper_log, $auto_wallpaper_log"

# Start hyprpaper and log output
log "Starting hyprpaper and logging to $hyprpaper_log"
hyprpaper >"$hyprpaper_log" 2>&1 </dev/null & disown
log "Hyprpaper started with PID $!"

# Start auto-wallpaper script and log output
#log "Starting auto-wallpaper script and logging to $auto_wallpaper_log"
source "$HOME/.config/hypr/scripts/auto-wallpaper.sh" >"$auto_wallpaper_log" 2>&1 </dev/null & disown
log "Auto-wallpaper script started with PID $!"

log "Script execution complete."
