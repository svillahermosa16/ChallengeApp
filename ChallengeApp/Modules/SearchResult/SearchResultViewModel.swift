import Foundation

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
            await beginSearch()
        }
    }
    @MainActor
    func beginSearch() async {
        state.isLoading = true
        do {
            let productSearchResponse = try await repository.searchProduct(query: state.searchQuery)
            state.products = productSearchResponse.results
        } catch {
            state.error = error as? APIError ?? .unknown
        }
        state.searchCompleted = true
        state.isLoading = false
    }
}
