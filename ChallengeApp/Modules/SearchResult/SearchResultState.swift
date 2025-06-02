import Foundation

struct SearchResultState: MVIViewState {
    var searchQuery: String = ""
    var products: [ProductMatch] = []
    var error: APIError?
    var isLoading: Bool = false
}
