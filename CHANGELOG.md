# BetterBags - BoE, WuE & BoA Changelog
All notable changes to this project will be documented in this file. Be aware that the [Unreleased] features are not yet available in the official tagged builds.

The format is based on [Keep a Changelog](http://keepachangelog.com/) and this project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]
### Fixed
- Increased scanning range to account for BoE with upgrade levels.

## [1.8.0] 2024-09-12
### Changed
- Renamed "WoE" to "WuE" to match the rest of the community.

## [1.7.1] 2024-09-05
### Fixed
- Fixed typo preventing addon settings from being remembered across reloads.

## [1.7.0] 2024-09-02
### Added
- Support for BetterBags Contexts

## [1.6.1] 2024-09-01
### Fixed
- Fixed a typo in the configuration options.

## [1.6.0] 2024-08-30
### Added
- Added a "Soulbound" category. It is disabled by default.

### Fixed
- Changing a configuration option now properly refreshes the item categories.
- The "Only Equippable" configuration is no longer always active and can be disabled normally.

## [1.5.1] 2024-08-26
### Fixed
- Resolved nil reference after changing `CategoryFilter` scope ([#4](https://github.com/AvyAddons/BetterBags_Bound/issues/4)).

## [1.5.0] 2024-08-25
### Added
- Support for [the Priority plugin](https://www.curseforge.com/wow/addons/betterbags-priority).

## [1.4.0] 2024-08-16
### Added
- The plugin now clears items from the BoE/WuE categories when equipping them. For now, this works only in Retail.

## [1.3.0] 2024-08-12
### Added
- Support for Warbound until Equipped (WuE)
- Plugin settings panel is now available

### Removed
- Removed support for 10.2.7

### Changed
- Only categorize equippable items. You can disable this in the settings.

## [1.2.0] 2024-07-25
### Changed
- Flush category on initialization to prevent stale items
- Bump Retail TOC to 11.0, 11.0.2

## [1.1.1] 2024-07-13
### Changed
- Bump Vanilla TOC to 1.15.3

## [1.1.0] 2024-05-08
### Added
- Add support for Cataclysm Classic 4.4.0 (courtesy of rissole)

### Changed
- Bump TOC to 10.2.7

## [1.0.1] 2024-04-13
### Changed
- Bump TOC to 10.2.6

## [1.0.0] 2023-02-19
### Added
- Added support for both Classic flavours:
  You can now use BetterBags - BoE & BoA in both Wrath and Vanilla!

## [0.1.1] 2023-01-17
### Changed
- Bump TOC to 10.2.5

## [0.1.0] 2023-01-09
### Added
- Initial release.
