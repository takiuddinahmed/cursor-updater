# cursor-updater (Linux)

A tiny, reliable updater for Cursor IDE (AppImage) using Cursor's official download API.

## Features
- Fetches latest Cursor release via API
- Downloads AppImage and updates safely
- Optional systemd timer for auto updates
- Desktop icon integration
- Designed for Arch/Archcraft/Openbox but works on most Linux distros

## Install

### One-liner install
```bash
curl -fsSL https://raw.githubusercontent.com/takiuddinahmed/cursor-updater/main/scripts/install.sh | bash
```

### Manual install
```bash
git clone https://github.com/takiuddinahmed/cursor-updater.git
cd cursor-updater
./scripts/install.sh
```

## Usage

Update Cursor manually:
```bash
sudo update-cursor
```

Update to insiders track:
```bash
sudo update-cursor insiders
```

## Enable auto-update (systemd)

Enable daily automatic updates:
```bash
sudo systemctl enable --now cursor-update.timer
```

Check timer status:
```bash
systemctl status cursor-update.timer
```

View last update logs:
```bash
journalctl -u cursor-update.service
```

## Uninstall

```bash
./scripts/uninstall.sh
```

## Notes

- Installs `update-cursor` into `/usr/local/bin`
- AppImage location: `/opt/cursor/cursor.AppImage`
- Symlink: `/usr/local/bin/cursor` → `/opt/cursor/cursor.AppImage`
- Desktop file: `/usr/share/applications/cursor.desktop`
- Icon: `/usr/share/pixmaps/cursor.png` (extracted from AppImage)
- Backups are created with timestamps: `cursor.AppImage.bak-YYYYMMDD-HHMMSS`

## License

MIT

