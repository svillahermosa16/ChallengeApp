import SwiftUI
import Combine

struct SearchResultView: MVIBaseView {
    @ObservedObject var viewModel: SearchResultViewModel
    @State private var isLoading: Bool = false
    
    var body: some View {
        VStack {
            Color.yellow
                .edgesIgnoringSafeArea(.all)
                .frame(height: 60)
            
            List(viewModel.state.products, id: \.id) { product in
                ProductView(product: product)
            }
            .scrollIndicators(.hidden)
            .listStyle(.plain)
            
        }
        .onAppear {
            Task {
                await viewModel.intentHandler(.search)
            }
        }
    }
}

struct ProductView: View {
    let product: ProductMatch
    var body: some View {
        HStack(alignment: .top) {
            if let imageUrl = product.pictures?.first?.url,
               let name = product.name,
               let attributes = product.attributes {
                AsyncImage(url: URL(string: imageUrl)!) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    default:
                        Image("placeholder")
                    }
                }
                .frame(width: 150, height: 150)
                
                
                VStack(alignment: .leading) {
                    Text(name)
                    Text("")
                }
            }
        }
        .frame(height: 150)
    }
}

#Preview {
    SearchResultView(viewModel: .init(state: .init(searchQuery: "Macbook"), repository: SearchRepository()))
}
