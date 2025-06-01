import Foundation

protocol SearchResultViewModelProtocol: MVIBaseViewModel, ObservableObject {
    var state: SearchResultState { get set }
    func intentHandler(_ intent: SearchResultIntent)
    func searchProducts(query: String) async
}

class SearchResultViewModel: MVIBaseViewModel {
    @Published var state: SearchResultState
    let repository: SearchRepositoryProtocol
    
    init(state: SearchResultState, repository: SearchRepositoryProtocol) {
        self.state = state
        self.repository = repository
    }
    
    @MainActor
    func intentHandler(_ intent: SearchResultIntent) async {
        switch intent {
        case .search:
            do {
                let productSearchResponse = try await repository.searchProduct(query: state.searchQuery)
                state.products = productSearchResponse.results.sorted { $0.dateValue ?? Date.distantPast < $1.dateValue ?? Date.distantPast
                }
            } catch {
                state.error = error
            }
        case .addFilters:
            print("")
        }
    }
}
