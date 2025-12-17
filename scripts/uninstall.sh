#!/usr/bin/env bash
set -euo pipefail

sudo rm -f /usr/local/bin/update-cursor

# systemd cleanup
if [ -f /etc/systemd/system/cursor-update.timer ] || [ -f /etc/systemd/system/cursor-update.service ]; then
  sudo systemctl disable --now cursor-update.timer 2>/dev/null || true
  sudo rm -f /etc/systemd/system/cursor-update.timer /etc/systemd/system/cursor-update.service
  sudo systemctl daemon-reload
fi

# desktop file cleanup
if [ -f /usr/share/applications/cursor.desktop ]; then
  sudo rm -f /usr/share/applications/cursor.desktop
  if command -v update-desktop-database >/dev/null 2>&1; then
    sudo update-desktop-database /usr/share/applications 2>/dev/null || true
  fi
  echo "✅ Removed desktop icon"
fi

# icon cleanup
if [ -f /usr/share/pixmaps/cursor.png ]; then
  sudo rm -f /usr/share/pixmaps/cursor.png
fi

echo "✅ Uninstalled update-cursor (+ optional timer + desktop icon)"

