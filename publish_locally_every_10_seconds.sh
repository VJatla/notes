#!/bin/bash
set -e  # Exit on error

# Change to the working directory
cd /home/vj/Dropbox/notes/

# Run continuously every 10 seconds
while true; do
    # Get current date and time
    current_date=$(date +%Y-%m-%d)
    current_time=$(date +%H:%M:%S)

    echo "[$current_date $current_time] Publishing site..."

    # Run Emacs in batch mode to publish the site
    emacs --batch -l publish.el

    echo "[$current_date $current_time] Done. Waiting 10 seconds..."

    # Wait 10 seconds before the next run
    sleep 10
done

