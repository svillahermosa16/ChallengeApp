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
    
    private let selectedBorderColor = Color.blue
    private let unselectedBorderColor = Color.gray.opacity(0.5)
    
    var body: some View {
        VStack(alignment: .leading) {
            if let pickerName = picker.pickerName {
                Text(pickerName)
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
                        if product.hasValidThumbnail,
                           let thumbnailUrlString = product.thumbnail,
                           let url = URL(string: thumbnailUrlString) {
                            AsyncImage(url: url) { phase in
                                switch phase {
                                case .success(let image):
                                    image.resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 40)
                                        .cornerRadius(4)
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
                        Text(product.pickerLabel ?? "N/A")
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(lineWidth: 1)
                    }
                    .onTapGesture {
                        if let productLabel = product.pickerLabel {
                            if self.selection == productLabel {
                                self.selection = nil
                            } else {
                                self.selection = productLabel
                            }
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func buildStandardPicker(currentPicker: Picker) -> some View {
        HStack(spacing: 8) {
            if let products = currentPicker.products {
                ForEach(products) { product in // Product must be Identifiable
                    HStack {
                        Text(product.pickerLabel ?? "N/A")
                            .padding(4)
                            .background {
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(lineWidth: 1)
                            }
                    }
                    .padding(.vertical, 4)
                    .onTapGesture {
                        if let productLabel = product.pickerLabel {
                            if self.selection == productLabel {
                                self.selection = nil
                            } else {
                                self.selection = productLabel
                            }
                        }
                    }
                }
                
            }
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
        ),
        Picker(
            pickerID: "DISPLAY_RESOLUTION",
            pickerName: "Resolución de pantalla",
            products: [
                Product(
                    productID: "MLA34164103",
                    pickerLabel: "3456 px x 2234 px",
                    pictureID: "",
                    thumbnail: "",
                    tags: ["selected"],
                    permalink: "",
                    productName: "Apple MacBook Pro Z1AF001AM - Negro - 128 GB - 2 TB - 120 Hz - 3456 px x 2234 px - Apple GPU - Apple - Apple M3 Max - M3 MAX - macOS",
                    autoCompleted: false
                )
            ],
            tags: [],
            attributes: [
                PickerAttribute(attributeID: "DISPLAY_RESOLUTION", template: "")
            ],
            valueNameDelimiter: ""
        ),
        Picker(
            pickerID: "WITH_TOUCH_SCREEN",
            pickerName: "Con pantalla táctil",
            products: [
                Product(
                    productID: "MLA34164103",
                    pickerLabel: "No",
                    pictureID: "",
                    thumbnail: "",
                    tags: ["selected"],
                    permalink: "",
                    productName: "Apple MacBook Pro Z1AF001AM - Negro - 128 GB - 2 TB - 120 Hz - 3456 px x 2234 px - Apple GPU - Apple - Apple M3 Max - M3 MAX - macOS",
                    autoCompleted: false
                )
            ],
            tags: [],
            attributes: [
                PickerAttribute(attributeID: "WITH_TOUCH_SCREEN", template: "")
            ],
            valueNameDelimiter: ""
        ),
        Picker(
            pickerID: "GRAPHIC_CARD",
            pickerName: "Placa de video",
            products: [
                Product(
                    productID: "MLA34164103",
                    pickerLabel: "Apple GPU",
                    pictureID: "",
                    thumbnail: "",
                    tags: ["selected"],
                    permalink: "",
                    productName: "Apple MacBook Pro Z1AF001AM - Negro - 128 GB - 2 TB - 120 Hz - 3456 px x 2234 px - Apple GPU - Apple - Apple M3 Max - M3 MAX - macOS",
                    autoCompleted: false
                )
            ],
            tags: [],
            attributes: [
                PickerAttribute(attributeID: "GRAPHIC_CARD", template: "")
            ],
            valueNameDelimiter: ""
        ),
        Picker(
            pickerID: "RAM_MEMORY_MODULE_TOTAL_CAPACITY",
            pickerName: "Memoria RAM",
            products: [
                Product(
                    productID: "MLA34164103",
                    pickerLabel: "128 GB",
                    pictureID: "",
                    thumbnail: "",
                    tags: ["selected"],
                    permalink: "",
                    productName: "Apple MacBook Pro Z1AF001AM - Negro - 128 GB - 2 TB - 120 Hz - 3456 px x 2234 px - Apple GPU - Apple - Apple M3 Max - M3 MAX - macOS",
                    autoCompleted: false
                )
            ],
            tags: [],
            attributes: [
                PickerAttribute(attributeID: "RAM_MEMORY_MODULE_TOTAL_CAPACITY", template: "")
            ],
            valueNameDelimiter: ""
        ),
        Picker(
            pickerID: "SSD_DATA_STORAGE_CAPACITY-HARD_DRIVE_DATA_STORAGE_CAPACITY",
            pickerName: "Capacidad",
            products: [
                Product(
                    productID: "MLA34164103",
                    pickerLabel: "2 TBSSD", // Note: JSON has "2 TBSSD", if "2 TB SSD" is intended, adjust here.
                    pictureID: "",
                    thumbnail: "",
                    tags: ["selected"],
                    permalink: "",
                    productName: "Apple MacBook Pro Z1AF001AM - Negro - 128 GB - 2 TB - 120 Hz - 3456 px x 2234 px - Apple GPU - Apple - Apple M3 Max - M3 MAX - macOS",
                    autoCompleted: false
                )
            ],
            tags: [],
            attributes: [
                PickerAttribute(attributeID: "SSD_DATA_STORAGE_CAPACITY", template: "SSD"),
                PickerAttribute(attributeID: "HARD_DRIVE_DATA_STORAGE_CAPACITY", template: "HDD")
            ],
            valueNameDelimiter: "-"
        ),
        Picker(
            pickerID: "OS_NAME-OS_EDITION-OS_VERSION",
            pickerName: "Sistema Operativo",
            products: [
                Product(
                    productID: "MLA34164103",
                    pickerLabel: "macOS",
                    pictureID: "",
                    thumbnail: "",
                    tags: ["selected"],
                    permalink: "",
                    productName: "Apple MacBook Pro Z1AF001AM - Negro - 128 GB - 2 TB - 120 Hz - 3456 px x 2234 px - Apple GPU - Apple - Apple M3 Max - M3 MAX - macOS",
                    autoCompleted: false
                )
            ],
            tags: [],
            attributes: [
                PickerAttribute(attributeID: "OS_NAME", template: ""),
                PickerAttribute(attributeID: "OS_EDITION", template: ""),
                PickerAttribute(attributeID: "OS_VERSION", template: "")
            ],
            valueNameDelimiter: "-"
        ),
        Picker(
            pickerID: "PROCESSOR_BRAND-PROCESSOR_LINE-PROCESSOR_MODEL",
            pickerName: "Procesador",
            products: [
                Product(
                    productID: "MLA34164103",
                    pickerLabel: "Apple  Apple M3 Max  M3 MAX",
                    pictureID: "",
                    thumbnail: "",
                    tags: ["selected"],
                    permalink: "",
                    productName: "Apple MacBook Pro Z1AF001AM - Negro - 128 GB - 2 TB - 120 Hz - 3456 px x 2234 px - Apple GPU - Apple - Apple M3 Max - M3 MAX - macOS",
                    autoCompleted: false
                )
            ],
            tags: [],
            attributes: [
                PickerAttribute(attributeID: "PROCESSOR_BRAND", template: " "),
                PickerAttribute(attributeID: "PROCESSOR_LINE", template: " "),
                PickerAttribute(attributeID: "PROCESSOR_MODEL", template: "")
            ],
            valueNameDelimiter: " "
        )
    ]
    PickerView(picker: previewPickers.first!)
}
