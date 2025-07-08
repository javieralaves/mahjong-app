import SwiftUI

struct MainView: View {
    @StateObject private var gameState = GameState()

    var body: some View {
        Text("Mahjong4")
            .font(.largeTitle)
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
