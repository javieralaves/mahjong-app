import Foundation

/// Represents a single Mahjong tile.
enum Tile: CaseIterable {
    // Suited tiles
    case bamboo(Int)    // 1-9
    case character(Int) // 1-9
    case dot(Int)       // 1-9

    // Honor tiles
    case wind(Wind)
    case dragon(Dragon)

    // Bonus tiles
    case flower(Int) // 1-4
    case season(Int) // 1-4

    enum Wind: String, CaseIterable {
        case east, south, west, north
    }

    enum Dragon: String, CaseIterable {
        case red, green, white
    }
}
