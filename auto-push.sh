#!/bin/bash
# Auto-push changes to GitHub when the HTML file is modified
# Runs via cron every 5 minutes

cd ~/hammersmithbridge

# Only proceed if there are actual changes
git add -A
if ! git diff --cached --quiet; then
  git commit -m "Auto-update: $(date '+%Y-%m-%d %H:%M')"
  git push origin main
fi
