import Foundation

extension Tile {
    /// Placeholder text representation of a tile for early UI prototyping.
    var displayString: String {
        switch self {
        case .bamboo(let value):
            return "Bamboo \(value)"
        case .character(let value):
            return "Character \(value)"
        case .dot(let value):
            return "Dot \(value)"
        case .wind(let wind):
            return wind.rawValue.capitalized + " Wind"
        case .dragon(let dragon):
            return dragon.rawValue.capitalized + " Dragon"
        case .flower(let value):
            return "Flower \(value)"
        case .season(let value):
            return "Season \(value)"
        }
    }
}
