# Mahjong4

Mahjong4 is an offline prototype of a four-player Mahjong game for iOS. This repository contains the initial scaffolding for Phase 1 development using Swift and SwiftUI.

## Current Phase
- **Phase 1: Offline Prototype** – establishing project structure, core models, and placeholder logic. No networking or multiplayer features are implemented at this stage.

## Tech Stack
- Swift 5
- SwiftUI (targeting iOS 16.0+)

## Folder Overview
```
Mahjong4/
├── Models/        # Game data types such as tiles and hands
├── Views/         # SwiftUI views
├── ViewModels/    # Observable objects for view state
├── Services/      # Future services (e.g., persistence)
├── Resources/     # Assets and localized strings
└── Utilities/     # Helpers and extensions
```

## Development Phases
1. **Phase 1 – Offline Prototype**: Build the basic skeleton, tile definitions, and simple UI.
2. **Phase 2 – Game Logic**: Implement tile and hand management, scoring, and turn flow. CPU-controlled players automatically draw and discard tiles on their turns.
3. **Phase 3 – Networking**: Add multiplayer and networking capabilities.

Updates to this plan will occur as development progresses.

## Tile Wall and Initial Hands
The game state builds a complete wall of 136 tiles which is shuffled at the start of a session. Each player is dealt 13 tiles from the top of this wall. Hands are automatically arranged using `TileHelpers.sortHand` after dealing and whenever tiles are drawn or discarded.

## Player Hand Display (Phase 1)
The first visual component renders a player's 13-tile hand. `TileView` shows a single tile using placeholder text while `TileRowView` arranges an array of tiles in a horizontal scrollable row. `MainView` now displays each player's hand using these views.

### Draw and Discard Interaction
On their turn, the active player can tap **Draw Tile** to take a tile from the wall. Once a fourteenth tile is in hand, tapping any tile discards it to a simple pile and re-enables the draw button. This loop mimics the real Mahjong flow of draw then discard.

### Turn Cycling
A simple turn manager now rotates play between all four participants in clockwise order (East, South, West, North). Only the active player's hand is visible and interactive. After a player draws and discards, `GameState` automatically advances `currentTurn` and the UI updates to show the next player.

### Win Detection
After each draw the hand is checked for a basic Mahjong win consisting of four melds and one pair. The logic lives in `Services/HandValidator.swift`. When a player draws a winning tile the game state sets `winningPlayer` and further turns are disabled. `MainView` displays a congratulatory message to indicate the winner.

### New Game Reset
When a win occurs a **New Game** button appears. Tapping it calls `GameState.resetGame()` which clears all hands and discards, reshuffles the wall, deals fresh hands, and resets the turn to Player 1. No state from the previous round is preserved.
