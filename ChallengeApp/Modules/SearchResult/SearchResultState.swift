import Foundation

struct SearchResultState: MVIViewState {
    var searchQuery: String = ""
    var products: [ProductMatch] = []
    var error: APIError?
    var isLoading: Bool = false
    var searchCompleted: Bool = false
}

extension SearchResultState {
    static func mock() -> SearchResultState {
        let mock = SearchResultState(searchQuery: "TEST", products: [], isLoading: false, searchCompleted: false)
        return mock
    }
}
