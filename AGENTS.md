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
