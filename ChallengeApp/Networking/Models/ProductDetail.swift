//
//  ProductDetail.swift
//  ChallengeApp
//
//  Created by VILLAHERMOSA SEBASTIAN on 01/06/2025.
//

import Foundation

// MARK: - Welcome
struct ProductDetail: Codable {
    let id, catalogProductID, status: String?
    let pdpTypes: [String]?
    let domainID, permalink, name, familyName: String?
    let type: String?
    let buyBoxWinner: JSONNull?
    let pickers: [Picker]?
    let pictures: [Picture]?
    let descriptionPictures: [JSONAny]?
    let mainFeatures, disclaimers: [VariableMetadata]?
    let attributes: [ProductAttribute]?
    let shortDescription: ShortDescription?
    let parentID: String?
    let userProduct: JSONNull?
    let childrenIDS: [JSONAny]?
    let settings: Settings?
    let qualityType: String?
    let releaseInfo, presaleInfo, enhancedContent: JSONNull?
    let tags: [JSONAny]?
    let dateCreated: String?
    let authorizedStores: JSONNull?
    let lastUpdated: String?
    let grouperID: JSONNull?
    let experiments: Experiments?
    
    enum CodingKeys: String, CodingKey {
        case id
        case catalogProductID = "catalog_product_id"
        case status
        case pdpTypes = "pdp_types"
        case domainID = "domain_id"
        case permalink, name
        case familyName = "family_name"
        case type
        case buyBoxWinner = "buy_box_winner"
        case pickers, pictures
        case descriptionPictures = "description_pictures"
        case mainFeatures = "main_features"
        case disclaimers, attributes
        case shortDescription = "short_description"
        case parentID = "parent_id"
        case userProduct = "user_product"
        case childrenIDS = "children_ids"
        case settings
        case qualityType = "quality_type"
        case releaseInfo = "release_info"
        case presaleInfo = "presale_info"
        case enhancedContent = "enhanced_content"
        case tags
        case dateCreated = "date_created"
        case authorizedStores = "authorized_stores"
        case lastUpdated = "last_updated"
        case grouperID = "grouper_id"
        case experiments
    }
}

struct ProductAttribute: Codable {
    let id, name, valueID, valueName: String?
    let values: [Value]?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case valueID = "value_id"
        case valueName = "value_name"
        case values
    }
}

struct Value: Codable {
    let id, name: String?
}

struct Experiments: Codable {
}

struct VariableMetadata: Codable, Identifiable {
    let id = UUID()
    let text: String
    let type: String
    let metadata: [String: JSONAny]
    
    enum CodingKeys: String, CodingKey {
        case text, type, metadata
    }
}

struct Product: Codable, Identifiable {
    let id = UUID()
    let productID, pickerLabel, pictureID: String?
    let thumbnail: String?
    let tags: [String]?
    let permalink, productName: String?
    let autoCompleted: Bool?
    
    enum CodingKeys: String, CodingKey {
        case productID = "product_id"
        case pickerLabel = "picker_label"
        case pictureID = "picture_id"
        case thumbnail, tags, permalink
        case productName = "product_name"
        case autoCompleted = "auto_completed"
    }
    
    var hasValidThumbnail: Bool {
        thumbnail?.isEmpty == false
    }
}

struct Picker: Codable, Identifiable {
    let id = UUID()
    let pickerID, pickerName: String?
    let products: [Product]?
    let tags: [JSONAny]?
    let attributes: [PickerAttribute]?
    let valueNameDelimiter: String?
    
    enum CodingKeys: String, CodingKey {
        case pickerID = "picker_id"
        case pickerName = "picker_name"
        case products, tags, attributes
        case valueNameDelimiter = "value_name_delimiter"
    }
    
    func hasAnyProductWithThumbnail() -> Bool {
        guard let products = self.products else {
            return false
        }
        return products.contains { $0.hasValidThumbnail }
    }
    
}


struct PickerAttribute: Codable {
    let attributeID, template: String?
    
    enum CodingKeys: String, CodingKey {
        case attributeID = "attribute_id"
        case template
    }
}

struct ShortDescription: Codable {
    let type, content: String?
}

extension ProductDetail {
    static func mockValue() -> ProductDetail {
        let jsonString = """
        {
            "id": "TEST",
            "catalog_product_id": "CAT456",
            "status": "active",
            "pdp_types": [],
            "domain_id": "DOM789",
            "permalink": "/test-product",
            "name": "Test Product",
            "family_name": "Test Family",
            "type": "simple",
            "buy_box_winner": null,
            "pickers": [],
            "pictures": [],
            "description_pictures": [],
            "main_features": [],
            "disclaimers": [],
            "attributes": [],
            "short_description": {
                "content": "Test description"
            },
            "parent_id": "PARENT001",
            "user_product": null,
            "children_ids": [],
            "settings": {
                "buyable": true
            },
            "quality_type": "premium",
            "release_info": null,
            "presale_info": null,
            "enhanced_content": null,
            "tags": [],
            "date_created": "2025-06-03T13:47:50Z",
            "authorized_stores": null,
            "last_updated": "2025-06-03T13:47:50Z",
            "grouper_id": null,
            "experiments": {
                "enabled": false
            }
        }
        """
        
        let jsonData = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        
        do {
            return try decoder.decode(ProductDetail.self, from: jsonData)
        } catch {
            fatalError("Failed to decode mock ProductDetail: \(error)")
        }
    }
}



