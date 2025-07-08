# Agents Guidance

This document describes the layout and conventions used in this repository. Always review this file before making changes.

## Project Layout
- **Mahjong4/** – Root iOS project.
  - **Models/** – Contains data structures such as `Tile` and future hand or player models.
  - **ViewModels/** – Observable objects following MVVM to manage state.
  - **Views/** – SwiftUI views only. Keep UI logic here.
  - **Services/** – Non-UI services like persistence or networking (future).
  - **Resources/** – Images, assets, or localization files.
  - **Utilities/** – Helper functions and extensions.

## Swift and SwiftUI Conventions
- Use **PascalCase** for type names (structs, enums, classes) and **camelCase** for variables and functions.
- Follow the MVVM pattern: keep game logic out of views. Place logic in models or view models.
- Prefer SwiftUI-native components without third-party dependencies.

## Development Notes
- This repository tracks phased development. Commit messages should be descriptive and prefixed with the phase, e.g., `PH1-01: Create Tile model`.
- Keep this file up to date if the project structure changes.

## Tile Wall Logic
- The `GameState` view model is responsible for creating and shuffling the full wall of 136 tiles. Use `shuffleWall()` to populate the wall array.
- Initial hand distribution for the four players occurs in `dealInitialHands()` within the same file.

## Player Model
- Located at `Mahjong4/Models/Player.swift`.
- Contains `id` (0–3) and `hand` (array of `Tile`).

## Sorting Convention
- Tile sorting is implemented in `Utilities/TileHelpers.swift`.
- Hands are sorted by suit in the order: Bamboo, Character, Dot, Winds (East–North), Dragons (Red–White), Flowers, Seasons, and then by numeric value within each group.
