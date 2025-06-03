#!/bin/bash
set -e  # Exit on error

# Get current date and time
current_date=$(date +%Y-%m-%d)
current_time=$(date +%H:%M:%S)

# Change to the working directory
cd /home/vj/Dropbox/notes/

# Run Emacs in batch mode to publish the site
emacs --batch -l publish.el

# Commit and push changes
git add .
git commit -m "Published website on $current_date at $current_time"
git push
