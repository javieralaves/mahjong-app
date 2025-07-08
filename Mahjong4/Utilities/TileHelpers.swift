import Foundation

/// Helper methods for working with tiles.
enum TileHelpers {
    /// Sort tiles primarily by suit/honor and then by their numeric value.
    static func sortTiles(_ tiles: [Tile]) -> [Tile] {
        return tiles.sorted { lhs, rhs in
            orderValue(for: lhs) < orderValue(for: rhs)
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
}
