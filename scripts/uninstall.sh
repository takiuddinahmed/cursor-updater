#!/usr/bin/env bash
set -euo pipefail

sudo rm -f /usr/local/bin/update-cursor

# systemd cleanup
if [ -f /etc/systemd/system/cursor-update.timer ] || [ -f /etc/systemd/system/cursor-update.service ]; then
  sudo systemctl disable --now cursor-update.timer 2>/dev/null || true
  sudo rm -f /etc/systemd/system/cursor-update.timer /etc/systemd/system/cursor-update.service
  sudo systemctl daemon-reload
fi

echo "✅ Uninstalled update-cursor (+ optional timer)"

