import Foundation

struct Currency: Decodable {
    let name: String
    let priceUSD: Double?

    enum CodingKeys: String, CodingKey {
        case name
        case priceUSD = "price_usd"
    }
}
