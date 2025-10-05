# BetterBags - BoE, WuE & BoA Changelog
All notable changes to this project will be documented in this file. Be aware that the [Unreleased] features are not yet available in the official tagged builds.

The format is based on [Keep a Changelog](http://keepachangelog.com/) and this project adheres to [Semantic Versioning](http://semver.org/).

## [1.12.2] 2025-10-06
### Changed
- Bump TOC to 11.2.5
- Bump MoP TOC to 5.5.1
### Improvements
- Added this plugin to the BetterBags group

## [1.12.1] 2025-10-04
### Fixed
- Improved WuE detection in Italian clients

## [1.12.0] 2025-08-06
### Changed
- Bump TOC to 11.2.0

## [1.11.0] 2025-07-20
### Added
- Support for Mists of Pandaria Classic

## [1.10.5] 2025-07-19
### Changed
- Improved loading of saved variables.
- Bump TOC to 11.1.7

## [1.10.4] 2025-06-29
### Changed
- Bump Classic TOC to 1.15.7

## [1.10.3] 2025-04-27
### Changed
- Bump TOC to 11.1.5

## [1.10.2] 2025-03-05
### Changed
- Bump Cata TOC to 4.4.2

## [1.10.1] 2025-03-04
### Changed
- Bump Classic TOC to 1.15.6

## [1.10.0] 2025-02-26
### Changed
- Bump TOC to 11.1.0
- Added Category

## [1.9.1] 2025-02-06
### Changed
- Updated internal interfaces to match base addon.

## [1.9.0] 2025-01-09
### Changed
- Internal update to scanning tooltip. This should make scanning faster.

## [1.8.7] 2024-12-19
### Changed
- Bump Retail TOC to 11.0.5, 11.0.7

## [1.8.6] 2024-12-14
### Changed
- Bump Cataclysm TOC to 4.4.1.

## [1.8.5] 2024-11-28
### Fixed
- Prevent Lua error when equipping BoE items in Classic.

## [1.8.4] 2024-11-27
### Changed
- Bump Vanilla TOC to 1.15.5.

## [1.8.3] 2024-11-18
### Changed
- Internal updates to context usage.

## [1.8.2] 2024-10-23
### Changed
- Bump Retail TOC to 11.0.2, 11.0.5

## [1.8.1] 2024-09-19
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
