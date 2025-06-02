import Foundation

struct ProductDetailState: MVIViewState {
    var productId: String
    var product: ProductDetail?
    var error: APIError?
    var isLoading: Bool = false
}
