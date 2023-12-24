import Foundation

struct Currency: Decodable {
    let name: String
    let price_usd: Double?
}
