#!/bin/bash
# ~/.config/yazelix/bash/open_file.sh

# Open a file in Neovim, integrating with Yazi and Zellij

# Function to check if Neovim is running
is_nvim_running() {
    pgrep -x "nvim" > /dev/null
}

# Function to open file in the existing Neovim session
open_in_existing_nvim() {
    local file_path="$1"
    # Send the file path to the existing Neovim session
    zellij send-keys "nvim $file_path"
}

# Function to open file in a new Zellij pane with Neovim
open_new_nvim_pane() {
    local file_path="$1"
    # Open a new vertical split with Neovim
    zellij splitv --size 75 -- nvim "$file_path"
}

# Main function to handle the file opening
main() {
    local file_path="$1"

    if [ ! -f "$file_path" ]; then
        echo "Error: File path ($file_path) does not exist"
        return
    fi

    # Capture YAZI_ID from Yazi’s pane (if set)
    local yazi_id="${YAZI_ID}"

    if [ -z "$yazi_id" ]; then
        echo "Warning: YAZI_ID not set in this environment. Yazi navigation may fail."
    fi

    # Check if Neovim is already running
    if is_nvim_running; then
        open_in_existing_nvim "$file_path"
    else
        open_new_nvim_pane "$file_path"
    fi
}

# Call the main function with the file path passed as an argument
main "$1"

