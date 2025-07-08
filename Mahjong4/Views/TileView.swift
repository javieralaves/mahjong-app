import SwiftUI

/// Displays a single Mahjong tile using placeholder text.
struct TileView: View {
    let tile: Tile
    var onTap: (() -> Void)? = nil

    var body: some View {
        Text(tile.displayString)
            .font(.caption)
            .frame(width: 40, height: 60)
            .background(Color.white)
            .cornerRadius(4)
            .shadow(radius: 1)
            .onTapGesture {
                onTap?()
            }
    }
}

struct TileView_Previews: PreviewProvider {
    static var previews: some View {
        TileView(tile: .bamboo(1))
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.gray.opacity(0.2))
    }
}
