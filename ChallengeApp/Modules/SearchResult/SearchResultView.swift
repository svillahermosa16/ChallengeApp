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
        ZStack {
            VStack(alignment: .center, spacing: 20) {
                Color.yellow
                    .edgesIgnoringSafeArea(.all)
                    .frame(height: 15)
                
                mainView()
                Spacer()
            }
            
            //MARK: Este modificador personalizado puede causar errores al correr la suit de tests, comentar en caso de ser necesario para correr los tests
            .onFirstAppear {
                searchProduct()
            }
            
            if viewModel.state.isLoading {
                ProgressView()
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                buildBackButton()
            }
            ToolbarItem(placement: .principal) {
                Text("Resultados de la búsqueda")
                    .font(Font.system(size: 18, weight: .bold))
            }
        }
    }
    
    @ViewBuilder
    private func mainView() -> some View {
        
        if let error = viewModel.state.error {
            ZStack {
                ErrorView(error: error, actionBtnMessage: "Reintentar") {
                    searchProduct()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            buildList()
        }
    }
    
    
    @ViewBuilder
    private func buildList() -> some View {
        ZStack {
            if !viewModel.state.products.isEmpty {
                List(viewModel.state.products, id: \.id) { product in
                    ProductView(product: product) { product in
                        selectProduct(product)
                    }
                }
                .scrollIndicators(.hidden)
                .listStyle(.plain)
            } else {
                if viewModel.state.searchCompleted {
                    Text("No se han encontrado resultados para la busqueda")
                        .font(.system(size: 16, weight: .heavy))
                }
            }
        }
    }
    
    @ViewBuilder
    private func buildBackButton() -> some View {
        Button(action: coordinator.pop) {
            Image(systemName: "chevron.left")
                .font(Font.system(size: 16))
                .foregroundStyle(.black)
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

