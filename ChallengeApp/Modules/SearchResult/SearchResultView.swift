import SwiftUI
import Combine

struct SearchResultView: MVIBaseView {
    @StateObject var viewModel: SearchResultViewModel
    @EnvironmentObject var coordinator: MainCoordinator
    
    init(searchInput: String, repository: SearchRepository) {
        self._viewModel = StateObject(wrappedValue: SearchResultViewModel(
            state: .init(searchQuery: searchInput),
            repository: repository
        ))
    }
    
    var body: some View {
        VStack {
            Color.yellow
                .edgesIgnoringSafeArea(.all)
                .frame(height: 30)
    
            if viewModel.state.error != nil {
                ErrorView(error: viewModel.state.error, actionBtnMessage: "Reintentar") {
                    searchProduct()
                }
            } else {
                mainView { product in
                    selectProduct(product)
                }
            }
            Spacer()
        }
        .onFirstAppear {
            searchProduct()
        }
    }
    
    @ViewBuilder
    private func mainView(tap: @escaping (ProductMatch) -> Void) -> some View {
        
        ZStack {
            if !viewModel.state.products.isEmpty {
                List(viewModel.state.products, id: \.id) { product in
                    ProductView(product: product) { product in
                        tap(product)
                    }
                    .listRowSeparator(.hidden)
                }
                .scrollIndicators(.hidden)
                .listStyle(.plain)
            } else {
                Text("No se han encontrado resultados para la busqueda")
                    .font(.system(size: 16, weight: .heavy))
            }
            
            if viewModel.state.isLoading {
                ProgressView()
            }
        }
    }
    
    private func searchProduct() {
        Task {
            await viewModel.intentHandler(.search)
        }
    }
    
    private func selectProduct(_ product: ProductMatch) {
        coordinator.push(.productDetail(product.id ?? ""))
    }
}

struct ProductView: View {
    let product: ProductMatch
    let tapAction: (ProductMatch) -> Void
    var body: some View {
        HStack(alignment: .center) {
            if let imageUrl = product.pictures?.first?.url,
               let name = product.name {
                AsyncImage(url: URL(string: imageUrl)!) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    default:
                        ProgressView()
                    }
                }
                .frame(width: 150, height: 150)
                
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(name)
                        .font(.system(size: 14, weight: .light))
                        .lineLimit(3)
                    Text("1.000.000")
                        .font(.system(size: 16, weight: .semibold))
                }
            }
        }
        .onTapGesture {
            tapAction(product)
        }
    }
}

