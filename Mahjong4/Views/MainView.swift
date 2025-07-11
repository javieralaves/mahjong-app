import SwiftUI

struct TileBackView: View {
    var body: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.3))
            .frame(width: 40, height: 60)
            .cornerRadius(4)
    }
}

struct MainView: View {
    @StateObject private var gameState = GameState()

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Mahjong4")
                .font(.largeTitle)

            if let winner = gameState.winningPlayer {
                Text("\u{1F389} Player \(winner + 1) wins!")
                    .font(.title)
                    .foregroundColor(.green)
                Button("New Game") {
                    gameState.resetGame()
                }
            }

            Text("Current Turn: Player \(gameState.currentTurn + 1)")
                .font(.headline)

            ForEach(gameState.players) { player in
                VStack(alignment: .leading, spacing: 8) {
                    Text("Player \(player.id + 1) Hand")
                        .font(.headline)

                    if player.id == gameState.currentTurn {
                        Button("Draw Tile") {
                            gameState.drawTile(for: player)
                        }
                        .disabled(gameState.hasDrawnThisTurn ||
                                  player.hand.count >= 14 ||
                                  gameState.winningPlayer != nil)

                        TileRowView(
                            tiles: player.hand,
                            onTileTap: { tile in
                                if gameState.winningPlayer == nil {
                                    gameState.discardTile(tile, for: player)
                                }
                            }
                        )
                    } else {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 4) {
                                ForEach(0..<player.hand.count, id: \.self) { _ in
                                    TileBackView()
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }

            if !gameState.discardPile.isEmpty {
                DiscardPileView(tiles: gameState.discardPile)
            }
        }
        .padding()
        .onAppear {
            gameState.resetGame()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
