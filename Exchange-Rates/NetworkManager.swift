import Alamofire

final class NetworkManager {

    static let shared = NetworkManager()

    private init() {}

    func fetchCurrencies(completion: @escaping ([Currency]?) -> Void) {
        let url = "https://rest.coinapi.io/v1/assets"

        let headers: HTTPHeaders = ["X-CoinAPI-Key": "FA35B24B-50EC-4982-84A8-A6466ED7F6E5"]

        AF.request(url, headers: headers).responseDecodable(of: [Currency].self) { response in
            switch response.result {
            case .success(let currencies):
                completion(currencies)
            case .failure(let error):
                print("Error fetching currencies: \(error)")
                completion(nil)
            }
        }
    }
}
