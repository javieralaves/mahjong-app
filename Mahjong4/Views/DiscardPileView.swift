import SwiftUI

/// Displays the tiles discarded by Player 1.
struct DiscardPileView: View {
    let tiles: [Tile]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Discards")
                .font(.headline)
            TileRowView(tiles: tiles)
        }
    }
}

struct DiscardPileView_Previews: PreviewProvider {
    static var previews: some View {
        DiscardPileView(tiles: [.bamboo(1), .character(2)])
            .previewLayout(.sizeThatFits)
    }
}
