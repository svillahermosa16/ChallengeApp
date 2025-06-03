import Foundation

class ProductDetailViewModel: MVIBaseViewModel {
    @Published var state: ProductDetailState
    let repository: SearchRepositoryProtocol
    init(state: ProductDetailState, repository: SearchRepositoryProtocol) {
        self.state = state
        self.repository = repository
    }
    
    @MainActor
    func intentHandler(_ intent: ProductDetailIntent) async {
        switch intent {
        case .loadProduct:
            state.isLoading = true
            do {
                let productDetailResponse = try await repository.searchProductDetails(productId: state.productId)
                self.state.product = productDetailResponse
            } catch {
                state.error = error as? APIError ?? .unknown
            }
            state.isLoading = false
        }
    }
    
}
