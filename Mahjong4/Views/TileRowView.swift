import SwiftUI

/// Displays a horizontal scrollable row of tiles.
struct TileRowView: View {
    let tiles: [Tile]
    var onTileTap: ((Tile) -> Void)? = nil
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 4) {
                ForEach(Array(tiles.enumerated()), id: \".offset\") { _, tile in
                    TileView(tile: tile, onTap: { onTileTap?(tile) })
                }
            }
            .padding(.horizontal)
        }
    }
}

struct TileRowView_Previews: PreviewProvider {
    static var previews: some View {
        TileRowView(tiles: [
            .bamboo(1), .character(2), .dot(3), .wind(.east), .dragon(.red)
        ])
    }
}
