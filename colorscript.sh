#!/bin/bash

# Define the file path
file_path="./hud.lz"

# Read offsets and colors from the configuration file
config_file="$(pwd)/offsets/11.17.0/homemenu/hud-offsets.sh"
mapfile -t config_array < "$config_file"

# Perform the hex edits
for config_line in "${config_array[@]}"; do
    # Split the line into offset and color
    read -r offset new_hex <<< "$config_line"

    printf "${new_hex}" | xxd -r -p | dd of="${file_path}" bs=1 seek=$(( 0x${offset} )) count=3 conv=notrunc

    echo "Changed color at ${offset}"
done

