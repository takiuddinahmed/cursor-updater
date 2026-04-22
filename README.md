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

This fetches the latest stable release. You can also pass an explicit track:
```bash
sudo update-cursor stable   # same as default
sudo update-cursor latest   # equivalent to stable
```

### Pre-release builds (Early Access / Nightly)

Cursor's public download API only serves the `stable` / `latest` track, so this
tool cannot install Early Access or Nightly builds directly. Those channels are
delivered through Cursor's in-app updater:

1. Install stable first with `sudo update-cursor`.
2. Open Cursor and go to **Settings → Beta**.
3. Switch the update channel to **Early Access** or **Nightly**.
4. Restart Cursor; it will self-update to that channel from then on.

> The previously documented `sudo update-cursor insiders` command is no longer
> supported — the `insiders` track was removed from Cursor's public API and the
> updater now exits with a pointer to the in-app Beta settings.

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

