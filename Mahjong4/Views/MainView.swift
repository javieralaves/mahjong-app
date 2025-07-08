import SwiftUI

struct MainView: View {
    @StateObject private var gameState = GameState()

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Mahjong4")
                .font(.largeTitle)

            Text("Player 1 Hand")
                .font(.headline)

            TileRowView(tiles: gameState.players.first?.hand ?? [])
        }
        .padding()
        .onAppear {
            gameState.shuffleWall()
            gameState.dealInitialHands()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
