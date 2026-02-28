#!/bin/bash
# Auto-push changes to GitHub when the HTML file is modified
# Runs via cron every 5 minutes

export PATH="/usr/local/bin:/usr/bin:/bin:/opt/homebrew/bin:$PATH"

cd ~/hammersmithbridge || exit 1

# Remove stale lock file if it exists (older than 5 minutes)
find .git -name "index.lock" -mmin +2 -delete 2>/dev/null

# Exit if another git process is actually running
if [ -f .git/index.lock ]; then
  exit 0
fi

# Only proceed if there are actual changes
git add -A
if ! git diff --cached --quiet; then
  git commit -m "Auto-update: $(date '+%Y-%m-%d %H:%M')"
  git push origin main
fi

# Also push any unpushed commits from previous failed pushes
if [ "$(git rev-parse HEAD)" != "$(git rev-parse origin/main 2>/dev/null)" ]; then
  git push origin main
fi
