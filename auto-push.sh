#!/bin/bash
# Auto-push changes to GitHub when the HTML file is modified
# Runs via cron every 5 minutes

export PATH="/usr/local/bin:/usr/bin:/bin:/opt/homebrew/bin:$PATH"

cd ~/hammersmithbridge || exit 1

# Only proceed if there are actual changes
git add -A
if ! git diff --cached --quiet; then
  git commit -m "Auto-update: $(date '+%Y-%m-%d %H:%M')"
  git push origin main >> ~/hammersmithbridge/autopush.log 2>&1
fi
