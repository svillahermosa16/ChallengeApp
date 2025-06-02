import SwiftUI
import Combine

struct HomeView: View {
    @EnvironmentObject var coordinator: MainCoordinator
    @State private var textInput: String = ""
    @State private var cartItems: [Int] = [0,0,0,0,0]
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        ZStack {
            
            LinearGradient(stops: [
                Gradient.Stop(color: .yellow, location: 0.15),
                Gradient.Stop(color: .white, location: 0.35),
            ], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                
                HStack {
                    HStack(spacing: 0) {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.gray)
                        TextField("Comenzá tu busqueda",
                                  text: $textInput)
                        .font(.system(size: 16, weight: .medium))
                        .focused($isTextFieldFocused)
                        .submitLabel(.search)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                isTextFieldFocused = false
                            }
                        }
                        .onSubmit {
                            coordinator.push(.productList(textInput))
                        }
                    }
                    .padding(5)
                    .background {
                        Capsule()
                            .foregroundStyle(.white)
                    }
                    
                    Button(action: {}) {
                        VStack(alignment: .center, spacing: -5) {
                            Text(String(cartItems.count))
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(.black)
                                .padding(.leading, 2)
                            Image(systemName: "cart")
                                .foregroundStyle(.black)
                        }
                    }
                }
                .padding(5)
                
                Spacer()
            }
            .padding(10)
        }
    }
    
}

#Preview {
    HomeView()
        .environmentObject(MainCoordinator())
}
