import Foundation

enum HomeIntent: MVIIntent {
    case fetchRecentProducts
    case searchProducts(String)
    case showCart
}
