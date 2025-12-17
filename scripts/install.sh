#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

sudo install -Dm755 "$REPO_DIR/scripts/cursor-update" /usr/local/bin/update-cursor

# optional: systemd timer install
if command -v systemctl >/dev/null 2>&1; then
  sudo install -Dm644 "$REPO_DIR/systemd/cursor-update.service" /etc/systemd/system/cursor-update.service
  sudo install -Dm644 "$REPO_DIR/systemd/cursor-update.timer" /etc/systemd/system/cursor-update.timer
  sudo systemctl daemon-reload
fi

echo "✅ Installed: /usr/local/bin/update-cursor"
echo "Run: sudo update-cursor"
echo "Optional auto-update:"
echo "  sudo systemctl enable --now cursor-update.timer"

