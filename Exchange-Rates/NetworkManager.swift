import Alamofire

class NetworkManager {

    static let shared = NetworkManager()

    private init() {}

    func fetchCurrencies(completion: @escaping ([Currency]?) -> Void) {
        let url = "https://rest.coinapi.io/v1/assets"

        let headers: HTTPHeaders = ["X-CoinAPI-Key": "E93E2E73-E9EE-4359-894C-4BABB9B3F06A"]

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
