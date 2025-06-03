import Foundation

struct ProductDetailState: MVIViewState {
    var productId: String
    var product: ProductDetail?
    var error: APIError?
    var isLoading: Bool = false
}

extension ProductDetailState {
    static func mock() -> ProductDetailState {
        let mock = ProductDetailState(productId: "TEST", product: nil, error: .unknown, isLoading: false)
        return mock
    }
}
