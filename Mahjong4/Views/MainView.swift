import SwiftUI

struct MainView: View {
    @StateObject private var gameState = GameState()

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Mahjong4")
                .font(.largeTitle)

            Button("Draw Tile") {
                if let player = gameState.players.first {
                    gameState.drawTile(for: player)
                }
            }
            .disabled(gameState.hasDrawnThisTurn || (gameState.players.first?.hand.count ?? 0) >= 14)

            Text("Player 1 Hand")
                .font(.headline)

            TileRowView(
                tiles: gameState.players.first?.hand ?? [],
                onTileTap: { tile in
                    if let player = gameState.players.first {
                        gameState.discardTile(tile, for: player)
                    }
                }
            )

            if !gameState.discardPile.isEmpty {
                DiscardPileView(tiles: gameState.discardPile)
            }
        }
        .padding()
        .onAppear {
            gameState.startNewGame()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
