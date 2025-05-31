import Foundation

protocol HomeViewModelProtocol {
    func fetchRecentProducts()
    func searchProducts(_ product: String) async
    func showCart()
}

class HomeViewModel: MVIBaseViewModel {
    @Published var state: HomeState
    
    init(state: HomeState) {
        self.state = state
    }
    
    func intentHandler(_ intent: HomeIntent) {
        switch intent {
        case .fetchRecentProducts:
            print("")
        case .searchProducts(let product):
            Task {
                await searchProducts(product)
            }
        case .showCart:
            print("")
        }
    }
    
}

extension HomeViewModel: HomeViewModelProtocol {
    
    func searchProducts(_ product: String) async {
        let networkService = NetworkService()
        var params = RequestParameters()
        params["status"] = "active"
        params["site_id"] = "MLA"
        params["q"] = product
        params["limit"] = "10"
        let headers: [String: String] = ["Authorization" : Constants.authToken]
        let apiRequest = APIRequest(path: ChallengeAppPaths.search.path.rawValue , method: .get, parameters: params, headers: headers)
        do {
            let response = try await networkService.request(apiRequest: apiRequest, responseType: ProductSearchResponse.self)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchRecentProducts() {
        
    }
    
    func showCart() {
        
    }
}

