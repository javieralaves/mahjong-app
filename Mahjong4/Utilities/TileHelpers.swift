import Foundation

/// Helper methods for working with tiles.
enum TileHelpers {
    /// Sort tiles primarily by suit/honor and then by their numeric value.
    static func sortTiles(_ tiles: [Tile]) -> [Tile] {
        return sortHand(tiles)
    }

    /// Sort a player's hand using the standard suit priority.
    static func sortHand(_ tiles: [Tile]) -> [Tile] {
        return tiles.sorted { lhs, rhs in
            handOrderValue(for: lhs) < handOrderValue(for: rhs)
        }
    }

    /// Provides a sortable integer for a tile.
    private static func orderValue(for tile: Tile) -> Int {
        switch tile {
        case .bamboo(let value):
            return 0 * 10 + value
        case .character(let value):
            return 1 * 10 + value
        case .dot(let value):
            return 2 * 10 + value
        case .wind(let wind):
            // East, South, West, North
            let index = Tile.Wind.allCases.firstIndex(of: wind) ?? 0
            return 3 * 10 + index
        case .dragon(let dragon):
            // Red, Green, White
            let index = Tile.Dragon.allCases.firstIndex(of: dragon) ?? 0
            return 4 * 10 + index
        case .flower(let value):
            return 5 * 10 + value
        case .season(let value):
            return 6 * 10 + value
        }
    }

    /// Provides ordering for `sortHand` using Character → Bamboo → Dot → Winds → Dragons.
    private static func handOrderValue(for tile: Tile) -> Int {
        switch tile {
        case .character(let value):
            return 0 * 10 + value
        case .bamboo(let value):
            return 1 * 10 + value
        case .dot(let value):
            return 2 * 10 + value
        case .wind(let wind):
            let index = Tile.Wind.allCases.firstIndex(of: wind) ?? 0
            return 3 * 10 + index
        case .dragon(let dragon):
            let index = Tile.Dragon.allCases.firstIndex(of: dragon) ?? 0
            return 4 * 10 + index
        case .flower(let value):
            return 5 * 10 + value
        case .season(let value):
            return 6 * 10 + value
        }
    }

    /// Returns an integer group value for suit boundaries used in views.
    static func suitGroup(for tile: Tile) -> Int {
        switch tile {
        case .character:
            return 0
        case .bamboo:
            return 1
        case .dot:
            return 2
        case .wind:
            return 3
        case .dragon:
            return 4
        case .flower:
            return 5
        case .season:
            return 6
        }
    }
}
