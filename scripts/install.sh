#!/usr/bin/env bash
set -euo pipefail

# Determine script location - handle both direct execution and piped execution
if [[ -n "${BASH_SOURCE[0]:-}" ]]; then
  # Running from a file
  REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
else
  # Running from a pipe (curl | bash)
  TMPDIR="$(mktemp -d)"
  trap 'rm -rf "$TMPDIR"' EXIT
  
  REPO_DIR="$TMPDIR"
  BASE_URL="https://raw.githubusercontent.com/takiuddinahmed/cursor-updater/main"
  
  echo "⬇️  Downloading files..."
  mkdir -p "$REPO_DIR/scripts" "$REPO_DIR/systemd"
  
  curl -fsSL "$BASE_URL/scripts/cursor-update" -o "$REPO_DIR/scripts/cursor-update"
  curl -fsSL "$BASE_URL/systemd/cursor-update.service" -o "$REPO_DIR/systemd/cursor-update.service"
  curl -fsSL "$BASE_URL/systemd/cursor-update.timer" -o "$REPO_DIR/systemd/cursor-update.timer"
  
  chmod +x "$REPO_DIR/scripts/cursor-update"
fi

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

