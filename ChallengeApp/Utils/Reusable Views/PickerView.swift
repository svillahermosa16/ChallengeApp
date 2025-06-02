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
    
    var body: some View {
        VStack(alignment: .leading) {
            if let pickerName = picker.pickerName {
                Text("\(pickerName): \(selection ?? "")")
                    .font(.headline)
                    .padding(.bottom, 5)
                
                if picker.hasAnyProductWithThumbnail() {
                    buildThumbnailPicker(currentPicker: picker)
                } else {
                    buildStandardPicker(currentPicker: picker)
                }
            }
        }
    }
    
    @ViewBuilder
    private func buildThumbnailPicker(currentPicker: Picker) -> some View {
        HStack(alignment: .center, spacing: 8) {
            if let products = currentPicker.products {
                ForEach(products) { product in
                    VStack {
                        Button(action: {
                            if let productLabel = product.pickerLabel {
                                if self.selection == productLabel {
                                    self.selection = nil
                                } else {
                                    self.selection = productLabel
                                }
                                onSelectionChange(self.selection == productLabel ? nil : productLabel)
                            }
                        }) {
                            if product.hasValidThumbnail, let thumbnailUrlString = product.thumbnail, let url = URL(string: thumbnailUrlString) {
                                AsyncImage(url: url) { phase in
                                    switch phase {
                                    case .success(let image):
                                        image.resizable()
                                            .scaledToFit()
                                            .frame(width: 40, height: 40)
                                    default:
                                        ProgressView()
                                            .frame(width: 40, height: 40)
                                    }
                                }
                            } else {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.1))
                                    .frame(width: 40, height: 40)
                                    .cornerRadius(4)
                                    .overlay(Image(systemName: "photo").foregroundColor(.gray))
                            }
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .padding(3)
                        .background {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(lineWidth: 1)
                        }
                        Text(product.pickerLabel ?? "N/A")
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func buildStandardPicker(currentPicker: Picker) -> some View {
        HStack(spacing: 8) {
            if let products = currentPicker.products {
                ForEach(products) { product in
                    HStack {
                        Button(action: {
                            if let productLabel = product.pickerLabel {
                                if self.selection == productLabel {
                                    self.selection = nil
                                } else {
                                    self.selection = productLabel
                                    onSelectionChange(self.selection == productLabel ? nil : productLabel)
                                }
                            }
                        }) {
                            Text(product.pickerLabel ?? "N/A")
                                .padding(4)
                                .background {
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(lineWidth: 1)
                                }
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
        }
    }}



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
