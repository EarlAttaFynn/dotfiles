#!/bin/bash

# Start logging
log_dir="/tmp/reload-waybar"
log_file="${log_dir}/reload-waybar_$(date '+%Y-%m-%d_%H-%M-%S').log"

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

# Kill any running waybar processes
log "Killing any existing waybar processes..."
killall -9 waybar >/dev/null 2>&1
sleep 1

# Start waybar and log output
waybar_log="/tmp/reload-waybar/waybar_$(date '+%Y-%m-%d_%H-%M-%S').log"
log "Starting waybar and logging to $waybar_log"
waybar >"$waybar_log" 2>&1 </dev/null & disown
log "Waybar started with PID $!"

log "Script execution complete."
