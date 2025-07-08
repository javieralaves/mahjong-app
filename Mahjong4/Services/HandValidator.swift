import Foundation

/// Validates if a hand is a standard winning Mahjong hand.
/// Supports only basic structure: 4 melds (chow/pong) + 1 pair.
enum HandValidator {
    /// Returns true if the given 14 tiles form 4 melds and a pair.
    static func isWinningHand(_ tiles: [Tile]) -> Bool {
        guard tiles.count == 14 else { return false }
        var counts = Array(repeating: 0, count: 34)
        for tile in tiles {
            guard let index = tileIndex(tile) else { return false }
            counts[index] += 1
        }

        for i in 0..<counts.count {
            if counts[i] >= 2 {
                counts[i] -= 2
                if checkMelds(&counts) { return true }
                counts[i] += 2
            }
        }
        return false
    }

    /// Recursively checks if remaining tiles form complete melds.
    private static func checkMelds(_ counts: inout [Int]) -> Bool {
        if let index = counts.firstIndex(where: { $0 > 0 }) {
            // Try pong
            if counts[index] >= 3 {
                counts[index] -= 3
                if checkMelds(&counts) { counts[index] += 3; return true }
                counts[index] += 3
            }

            // Try chow for suited tiles
            if isSuited(index) && index % 9 <= 6 &&
                counts[index + 1] > 0 && counts[index + 2] > 0 {
                counts[index] -= 1
                counts[index + 1] -= 1
                counts[index + 2] -= 1
                if checkMelds(&counts) {
                    counts[index] += 1
                    counts[index + 1] += 1
                    counts[index + 2] += 1
                    return true
                }
                counts[index] += 1
                counts[index + 1] += 1
                counts[index + 2] += 1
            }
            return false
        } else {
            return true
        }
    }

    /// Returns an index (0-33) for tile types used in counts.
    private static func tileIndex(_ tile: Tile) -> Int? {
        switch tile {
        case .bamboo(let value):
            return (1...9).contains(value) ? value - 1 : nil
        case .character(let value):
            return (1...9).contains(value) ? 9 + value - 1 : nil
        case .dot(let value):
            return (1...9).contains(value) ? 18 + value - 1 : nil
        case .wind(let wind):
            if let idx = Tile.Wind.allCases.firstIndex(of: wind) {
                return 27 + idx
            }
            return nil
        case .dragon(let dragon):
            if let idx = Tile.Dragon.allCases.firstIndex(of: dragon) {
                return 31 + idx
            }
            return nil
        default:
            // Flowers and seasons are ignored for standard winning hands
            return nil
        }
    }

    private static func isSuited(_ index: Int) -> Bool {
        return index < 27
    }
}
