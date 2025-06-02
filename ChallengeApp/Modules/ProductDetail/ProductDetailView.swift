import SwiftUI
import Combine

struct ProductDetailView: MVIBaseView {
    @ObservedObject var viewModel: ProductDetailViewModel
    @EnvironmentObject var coordinator: MainCoordinator
    @State private var selections: [String: String?] = [:]
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Color.yellow
                .edgesIgnoringSafeArea(.all)
                .frame(height: 30)
            
            if let error = viewModel.state.error {
                ZStack {
                    ErrorView(error: error, actionBtnMessage: "Reintentar") {
                        loadProduct()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    VStack(alignment: .leading) {
                        Text(viewModel.state.product?.name ?? "")
                        VStack {
                            buildCarousel()
                        }
                        buildPickerViewSelector()
                            .padding(.horizontal, 20)
                    }
                    
                }
                .padding(.horizontal, 10)
            }
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
    private func buildCarousel() -> some View {
        if let product = viewModel.state.product {
            let images: [URL] = product.pictures?.compactMap { pictureElement -> URL? in
                pictureElement.url.flatMap { urlString -> URL? in
                    URL(string: urlString)
                }
            } ?? []
            ImageCarousel(imageSource: images)
        }
    }
    
    @ViewBuilder
    private func buildPickerViewSelector() -> some View {
        if let pickers = viewModel.state.product?.pickers {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(pickers) { picker in
                    if !(picker.products?.count ?? 1 == 1) || picker.hasAnyProductWithThumbnail() {
                        PickerView(picker: picker, onSelectionChange: { newSelection in
                            selections[picker.pickerID ?? ""] = newSelection
                        })
                    }
                }
            }
        }
    }
}


#Preview {
    ProductDetailView(viewModel: ProductDetailViewModel.init(state: .init(productId: "MLA34164103"), repository: SearchRepository()))
        .environmentObject(MainCoordinator())
}

