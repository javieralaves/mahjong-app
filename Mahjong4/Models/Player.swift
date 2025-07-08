import Foundation

/// Represents a player in the game.
struct Player: Identifiable {
    let id: Int            // 0-3
    var hand: [Tile] = []  // 13 tiles dealt at start
}

