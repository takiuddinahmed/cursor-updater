# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed
- **BREAKING:** The `insiders` track argument is no longer accepted. Cursor's
  public download API only serves `stable` and `latest`; pre-release channels
  (Early Access, Nightly) are delivered via Cursor's in-app updater
  (Settings → Beta). Passing `insiders` (or other legacy pre-release names
  such as `nightly`, `early-access`, `beta`, `preview`, `canary`) now exits
  with code 2 and a message pointing to the in-app Beta settings.
- API requests now go to `https://cursor.com/api/download` directly instead of
  `https://www.cursor.com/...`, avoiding an unnecessary 308 redirect.

### Fixed
- Surface the real HTTP status code and response body when the download API
  returns a non-200, instead of the misleading `❌ Empty response from API.`
  message. The previous `curl -fsSL ... || true` pattern swallowed the server
  error body entirely (fixes [#1](https://github.com/takiuddinahmed/cursor-updater/issues/1)).

## [1.0.1] - 2025-12-17

### Added
- Desktop icon support with automatic installation
- Desktop file integration (`/usr/share/applications/cursor.desktop`)
- Automatic icon extraction from AppImage during updates
- Icon installation to `/usr/share/pixmaps/cursor.png`

### Fixed
- Install script now properly handles piped execution (`curl | bash`)
- Fixed unbound `BASH_SOURCE[0]` variable when script is executed via pipe
- Added proper file downloading to temp directory for piped execution
- Added cleanup trap to remove temp directory on exit

## [1.0.0] - 2025-12-17

### Added
- Initial release
- Main updater script with API integration
- Install/uninstall scripts
- Systemd service and timer for auto-updates
- Support for stable and insiders tracks
- Automatic backup of existing AppImage before update

