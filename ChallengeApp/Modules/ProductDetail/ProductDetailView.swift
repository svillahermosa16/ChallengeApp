import SwiftUI
import Combine

struct ProductDetailView: MVIBaseView {
    @ObservedObject var viewModel: ProductDetailViewModel
    @EnvironmentObject var coordinator: MainCoordinator
    @State private var selections: [String: String?] = [:]
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 20) {
                Color.yellow
                    .edgesIgnoringSafeArea(.all)
                    .frame(height: 15)
                
                mainView()
            }
            .onAppear {
                loadProduct()
            }
            progressView()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                buildBackButton()
            }
            ToolbarItem(placement: .principal) {
                Text("Detalles del producto")
                    .font(Font.system(size: 18, weight: .bold))
            }
        }
    }
    
    private func loadProduct() {
        Task {
            await viewModel.intentHandler(.loadProduct)
        }
    }
    
    @ViewBuilder
    private func progressView() -> some View {
        if viewModel.state.isLoading {
            ProgressView()
        }
    }
    
    @ViewBuilder
    private func mainView() -> some View {
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
                        .font(Font.system(size: 16, weight: .medium))
                        .padding(.horizontal, 10)

                    VStack {
                        buildCarousel()
                            .padding(.horizontal, 10)

                    }
                    
                    VStack(alignment: .leading, spacing: 30) {
                        buildPickerViewSelector()
                        buildFeaturesView()
                        buildDescription()
                    }
                    .padding(.horizontal, 20)
                }
            }
            .padding(.horizontal, 10)
            .scrollIndicators(.hidden)
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
        if let pickers = viewModel.state.product?.pickers, !pickers.isEmpty {
            VStack(alignment: .leading, spacing: 20) {
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
    
    @ViewBuilder
    private func buildFeaturesView() -> some View {
        if let attributes = viewModel.state.product?.mainFeatures, !attributes.isEmpty {
            VStack(alignment: .leading, spacing: 15) {
                Text("Lo que tenés que saber:")
                    .font(Font.system(size: 16, weight: .medium))
                VStack(alignment: .leading, spacing: 5) {
                    ForEach(attributes) { attribute in
                        HStack(spacing: 5) {
                            Circle()
                                .frame(width: 5, height: 5)
                                .foregroundStyle(.gray)
                            
                            Text(attribute.text)
                                .font(Font.system(size: 14, weight: .regular))
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func buildDescription() -> some View {
        if let disclaimers = viewModel.state.product?.disclaimers, !disclaimers.isEmpty {
            VStack(alignment: .leading, spacing: 15) {
                Text("Descripción")
                    .font(Font.system(size: 16, weight: .medium))
                
                VStack(alignment: .leading) {
                    Text("Aviso legal")
                        .font(Font.system(size: 14, weight: .medium))
                    
                    ForEach(disclaimers) { disclaimer in
                        HStack(spacing: 10) {
                            Circle()
                                .frame(width: 5, height: 5)
                                .foregroundStyle(.gray)
                            
                            Text(disclaimer.text)
                                .font(Font.system(size: 14, weight: .regular))
                        }
                    }
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
}


#Preview {
    ProductDetailView(viewModel: ProductDetailViewModel.init(state: .init(productId: "MLA34164103"), repository: SearchRepository()))
        .environmentObject(MainCoordinator())
}

