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

### Draw & Discard
- `GameState` owns the `drawTile(for:)` and `discardTile(_:for:)` methods. These modify a player's hand, update the discard pile, and toggle a `hasDrawnThisTurn` flag.
- `TileView` supports an optional `onTap` closure so views like `TileRowView` can forward tap events for discarding.

## Player Model
- Located at `Mahjong4/Models/Player.swift`.
- Contains `id` (0–3) and `hand` (array of `Tile`).
- New `isCPU` flag marks automated players. Player 0 is human while players 1–3 are CPU controlled.

## Sorting Convention
- Sorting helpers live in `Utilities/TileHelpers.swift`.
- Use `sortHand(_:)` to arrange any array of tiles.
- Tiles are ordered Characters → Bamboo → Dots → Winds (East–North) → Dragons (Red–White) → Flowers → Seasons with numeric order within each group.
- Hands are sorted after the initial deal, after each draw, and after each discard. Do not implement custom sorting in views or other view models; always use the helper.

## UI Components
- `TileView` and `TileRowView` are located in `Mahjong4/Views/`.
- Name view files using the pattern `NameView.swift` (PascalCase) and keep SwiftUI code free of game logic.
- Views are fed data from view models; they should not modify `GameState` directly.

### Turn Management
- `GameState` stores `currentTurn` (0-3) to track whose turn it is and exposes `advanceTurn()` which increments this value modulo four and resets `hasDrawnThisTurn`.
- `drawTile(for:)` and `discardTile(_:for:)` must check that the passed player matches `currentTurn`. Successful discards call `advanceTurn()` automatically.
- Views enable draw and discard interaction only for the active player indicated by `currentTurn`.
- CPU behavior lives in `GameState` within `triggerCPUTurnIfNeeded()` which draws and discards for CPU players using those same methods.

### Win Validation
- `Services/HandValidator.swift` contains `isWinningHand(_:)` which checks for four melds plus a pair.
- After `drawTile(for:)` adds a fourteenth tile, the validator runs. If it returns `true`, `winningPlayer` is set on `GameState`.
- When `winningPlayer` is non-nil the game freezes: draw, discard and turn advancement calls exit early until `resetGame()` resets state.

### Game Reset
- `GameState.resetGame()` (ViewModels/GameState.swift) clears all hands and discards, shuffles a new wall, deals fresh hands and resets `currentTurn` and `winningPlayer`.
- The UI should show a "New Game" button only after a win and call this method on tap.
- Each reset starts a stateless new round; no previous game data is kept.
