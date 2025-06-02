import SwiftUI
import Combine

struct ProductDetailView: MVIBaseView {
    @ObservedObject var viewModel: ProductDetailViewModel
    @EnvironmentObject var coordinator: MainCoordinator
    var body: some View {
        VStack(alignment: .center) {
            Color.yellow
                .edgesIgnoringSafeArea(.all)
                .frame(height: 30)
            if viewModel.state.error != nil {
                ErrorView(error: viewModel.state.error, actionBtnMessage: "Reintentar") {
                    loadProduct()
                }
            } else {
                ScrollView {
                    Text(viewModel.state.product?.name ?? "")
                    buildCarousel()
                    buildPickerViewSelector()
                }
                .padding(.horizontal, 10)
            }
            Spacer()
        }
        .onAppear {
            loadProduct()
        }
        
    }
    
    private func loadProduct() {
        Task {
            await viewModel.intentHandler(.loadProduct)
        }
    }
    
    @ViewBuilder
    private func buildErrorView(error: APIError?) -> some View {
        
    }
    
    @ViewBuilder
    private func buildCarousel() -> some View {
        if let product = viewModel.state.product {
            let images: [URL] = product.pictures?.compactMap { pictureElement -> URL? in
                pictureElement.url.flatMap { urlString -> URL? in
                    URL(string: urlString)
                }
            } ?? []
            ImageCarousel(imageSource: images)
                .frame(height: 300)

        }
    }
    
    @ViewBuilder
    private func buildPickerViewSelector() -> some View {
        if let pickers = viewModel.state.product?.pickers {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(pickers) { picker in
                    PickerView(picker: picker)
                }
            }
        }
    }
}


#Preview {
    ProductDetailView(viewModel: ProductDetailViewModel.init(state: .init(productId: "MLA34164103"), repository: SearchRepository()))
        .environmentObject(MainCoordinator())
}

