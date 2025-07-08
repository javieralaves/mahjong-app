import Foundation

/// Manages game state including players and the tile wall.
class GameState: ObservableObject {
    /// The complete wall of tiles. Tiles are removed from here as they are dealt.
    @Published private(set) var wall: [Tile] = []

    /// Four players participating in the game.
    @Published private(set) var players: [Player] = (0..<4).map { Player(id: $0) }

    /// Tiles discarded during play.
    @Published private(set) var discardPile: [Tile] = []

    /// Indicates if the current player has drawn this turn.
    @Published var hasDrawnThisTurn: Bool = false
    /// Index of the player whose turn it is. 0 = East.
    @Published var currentTurn: Int = 0

    /// The player index that has won the game, if any.
    @Published var winningPlayer: Int? = nil

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
            hand = TileHelpers.sortHand(hand)
            players[index].hand = hand
            print("Player \(players[index].id) hand: \(hand)")
        }

        print("Remaining tiles in wall: \(wall.count)")
    }

    /// Resets state for a new game session.
    func startNewGame() {
        currentTurn = 0
        shuffleWall()
        dealInitialHands()
        discardPile = []
        hasDrawnThisTurn = false
        winningPlayer = nil
    }

    /// Draws a single tile for the provided player.
    func drawTile(for player: Player) {
        guard winningPlayer == nil else { return }
        guard let index = players.firstIndex(where: { $0.id == player.id }) else { return }
        guard player.id == currentTurn else { return }
        guard !hasDrawnThisTurn, players[index].hand.count < 14, let tile = wall.first else { return }

        players[index].hand.append(tile)
        wall.removeFirst()
        players[index].hand = TileHelpers.sortHand(players[index].hand)
        hasDrawnThisTurn = true

        if HandValidator.isWinningHand(players[index].hand) {
            winningPlayer = player.id
        }

    }

    /// Discards the specified tile from the player's hand.
    func discardTile(_ tile: Tile, for player: Player) {
        guard winningPlayer == nil else { return }
        guard player.id == currentTurn else { return }
        guard let index = players.firstIndex(where: { $0.id == player.id }) else { return }
        guard hasDrawnThisTurn, let removeIndex = players[index].hand.firstIndex(of: tile) else { return }

        players[index].hand.remove(at: removeIndex)
        discardPile.append(tile)
        players[index].hand = TileHelpers.sortHand(players[index].hand)
        hasDrawnThisTurn = false
        advanceTurn()
    }
    /// Advances to the next player's turn clockwise.
    func advanceTurn() {
        guard winningPlayer == nil else { return }
        currentTurn = (currentTurn + 1) % 4
        hasDrawnThisTurn = false
    }
}
