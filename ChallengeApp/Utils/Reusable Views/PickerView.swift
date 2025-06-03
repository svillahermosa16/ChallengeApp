//
//  PickerView.swift
//  ChallengeApp
//
//  Created by VILLAHERMOSA SEBASTIAN on 02/06/2025.
//

import SwiftUI

struct PickerView: View {
    let picker: Picker
    @State var selection: String?
    let onSelectionChange: (String?) -> Void

    private let selectedBorderColor = Color.blue
    private let unselectedBorderColor = Color.gray.opacity(0.5)
    private let standardBorderColor = Color.black
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let pickerName = picker.pickerName {
                pickerHeader(name: pickerName)
                pickerContent()
            }
        }
    }
}

private extension PickerView {
    func pickerHeader(name: String) -> some View {
        Text("\(name): \(selection ?? "")")
            .font(Font.system(size: 14, weight: .regular))
    }
}

private extension PickerView {
    @ViewBuilder
    func pickerContent() -> some View {
        if picker.hasAnyProductWithThumbnail() {
            thumbnailPicker()
        } else {
            standardPicker()
        }
    }
    
    @ViewBuilder
    func thumbnailPicker() -> some View {
        HStack(alignment: .center, spacing: 8) {
            if let products = picker.products {
                ForEach(products) { product in
                    ThumbnailPickerButton(
                        product: product,
                        isSelected: isSelected(product),
                        onTap: { handleSelection(product) }
                    )
                }
            }
        }
    }
    
    @ViewBuilder
    func standardPicker() -> some View {
        HStack(spacing: 8) {
            if let products = picker.products {
                ForEach(products) { product in
                    StandardPickerButton(
                        product: product,
                        isSelected: isSelected(product),
                        onTap: { handleSelection(product) }
                    )
                }
            }
        }
    }
}

private extension PickerView {
    @ViewBuilder
    func ThumbnailPickerButton(
        product: Product,
        isSelected: Bool,
        onTap: @escaping () -> Void
    ) -> some View {
        Button(action: onTap) {
            VStack(spacing: 4) {
                thumbnailImage(for: product)
                thumbnailLabel(for: product)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .padding(3)
        .background {
            RoundedRectangle(cornerRadius: 5)
                .stroke(
                    isSelected ? selectedBorderColor : unselectedBorderColor,
                    lineWidth: isSelected ? 2 : 1
                )
        }
    }
    
    @ViewBuilder
    func StandardPickerButton(
        product: Product,
        isSelected: Bool,
        onTap: @escaping () -> Void
    ) -> some View {
        Button(action: onTap) {
            Text(product.pickerLabel ?? "N/A")
                .foregroundColor(.black)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
        }
        .background {
            RoundedRectangle(cornerRadius: 5)
                .stroke(
                    isSelected ? selectedBorderColor : standardBorderColor,
                    lineWidth: isSelected ? 2 : 1
                )
        }
    }
}

private extension PickerView {
    @ViewBuilder
    func thumbnailImage(for product: Product) -> some View {
        if product.hasValidThumbnail,
           let thumbnailUrlString = product.thumbnail,
           let url = URL(string: thumbnailUrlString) {
            
            AsyncImage(url: url) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                default:
                    ProgressView()
                        .frame(width: 40, height: 40)
                }
            }
        } else {
            placeholderImage()
        }
    }
    
    func placeholderImage() -> some View {
        Rectangle()
            .fill(Color.gray.opacity(0.1))
            .frame(width: 40, height: 40)
            .cornerRadius(4)
            .overlay(
                Image(systemName: "photo")
                    .foregroundColor(.gray)
            )
    }
    
    func thumbnailLabel(for product: Product) -> some View {
        Text(product.pickerLabel ?? "N/A")
            .lineLimit(1)
            .foregroundStyle(.black)
            .font(Font.system(size: 14, weight: .regular))
    }
}

private extension PickerView {
    func isSelected(_ product: Product) -> Bool {
        selection == product.pickerLabel
    }
    
    func handleSelection(_ product: Product) {
        guard let productLabel = product.pickerLabel else { return }
        
        if selection == productLabel {
            selection = nil
            onSelectionChange(nil)
        } else {
            selection = productLabel
            onSelectionChange(productLabel)
        }
    }
}



#Preview {
    let previewPickers: [Picker] = [
        Picker(
            pickerID: "COLOR",
            pickerName: "Color",
            products: [
                Product(
                    productID: "MLA34164103",
                    pickerLabel: "Negro",
                    pictureID: "944940-MLA74926887839_032024",
                    thumbnail: "https://http2.mlstatic.com/D_NQ_NP_944940-MLA74926887839_032024-I.jpg",
                    tags: ["selected"],
                    permalink: "",
                    productName: "Apple MacBook Pro Z1AF001AM - Negro - 128 GB - 2 TB - 120 Hz - 3456 px x 2234 px - Apple GPU - Apple - Apple M3 Max - M3 MAX - macOS",
                    autoCompleted: false
                )
            ],
            tags: [], // Corresponds to "tags": [] in JSON
            attributes: [
                PickerAttribute(attributeID: "COLOR", template: "")
            ],
            valueNameDelimiter: ""
        )
    ]
    PickerView(picker: previewPickers.first!, onSelectionChange: {_ in })
}
