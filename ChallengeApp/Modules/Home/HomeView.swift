import SwiftUI
import Combine

struct HomeView: View {
    @EnvironmentObject var coordinator: MainCoordinator
    @State private var textInput: String = ""
    @State private var cartItems: [Int] = [0,0,0,0,0]
    @FocusState private var isTextFieldFocused: Bool {
        didSet {
            if isTextFieldFocused {
                isShowingHelperText = false
            }
        }
    }
    @State private var isShowingHelperText: Bool = false
    var body: some View {
        ZStack {
            
            LinearGradient(stops: [
                Gradient.Stop(color: .yellow, location: 0.15),
                Gradient.Stop(color: .white, location: 0.35),
            ], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
                
                buildSearchView()
                buildEmptySearchView()
                
                Spacer()
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 15)
        }
    }
    
    @ViewBuilder
    private func buildSearchView() -> some View {
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
                    if !textInput.isEmpty {
                        coordinator.push(.productList(textInput))
                    } else {
                        isShowingHelperText = true
                    }
                }
            }
            .padding(10)
            .background {
                Capsule()
                    .foregroundStyle(.white)
            }
        }
    }
    
    @ViewBuilder
    private func buildEmptySearchView() -> some View {
        
        if isShowingHelperText && !isTextFieldFocused {
            HStack {
                Image(systemName: "xmark.circle")
                    .foregroundStyle(.red)
                Text("Debes ingresar un texto de busqueda")
                    .foregroundStyle(.red)
                    .font(.system(size: 16, weight: .medium))
            }
            .padding(15)
            .background {
                Capsule()
                    .foregroundStyle(.white)
                    .shadow(
                        color: Color.black.opacity(0.1),
                        radius: 6,
                        x: 0,
                        y: 3
                    )
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(MainCoordinator())
}
