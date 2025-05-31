import Foundation

struct HomeState: MVIViewState {
    var email: String = ""
    var password: String = ""
    var isLogged: String = "❌"
    
    var isUserLogged: Bool {
        password == "bflmpsvz"
    }
    
}
