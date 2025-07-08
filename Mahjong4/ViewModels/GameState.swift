import Foundation

/// Manages game state including players and the tile wall.
class GameState: ObservableObject {
    /// The complete wall of tiles. Tiles are removed from here as they are dealt.
    @Published private(set) var wall: [Tile] = []

    /// Four players participating in the game.
    @Published private(set) var players: [Player] = (0..<4).map { Player(id: $0) }

    /// Creates and shuffles the full wall of 136 tiles.
    func shuffleWall() {
        var tiles: [Tile] = []

        // Suited tiles: 1-9 of each suit with four copies each
        for value in 1...9 {
            for _ in 0..<4 {
                tiles.append(.bamboo(value))
                tiles.append(.character(value))
                tiles.append(.dot(value))
            }
        }

        // Winds and dragons: four copies each
        for wind in Tile.Wind.allCases {
            for _ in 0..<4 {
                tiles.append(.wind(wind))
            }
        }

        for dragon in Tile.Dragon.allCases {
            for _ in 0..<4 {
                tiles.append(.dragon(dragon))
            }
        }

        // Flowers and seasons: one copy each
        for value in 1...4 {
            tiles.append(.flower(value))
            tiles.append(.season(value))
        }

        tiles.shuffle()
        wall = tiles
    }

    /// Deals 13 tiles to each player from the wall.
    func dealInitialHands() {
        // Ensure the wall is shuffled and full
        guard wall.count >= 16 * 4 + 8 else { return }

        for index in players.indices {
            var hand: [Tile] = []
            for _ in 0..<13 {
                if let tile = wall.first {
                    hand.append(tile)
                    wall.removeFirst()
                }
            }
            hand = TileHelpers.sortTiles(hand)
            players[index].hand = hand
            print("Player \(players[index].id) hand: \(hand)")
        }

        print("Remaining tiles in wall: \(wall.count)")
    }
}
