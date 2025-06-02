//
//  ProductMatch.swift
//  ChallengeApp
//
//  Created by VILLAHERMOSA SEBASTIAN on 31/05/2025.
//

import Foundation


struct ProductSearchResponse: Codable {
    let paging: Paging?
    let keywords: String?
    let results: [ProductMatch]
}

struct Paging: Codable {
    let total, limit, offset: Int?
}

struct ProductMatch: Codable, Identifiable {
    let id: String?
    let dateCreated: String?
    let catalogProductID: String?
    let pdpTypes: [JSONAny]?
    let status, domainID: String?
    let settings: Settings?
    let name: String?
    let mainFeatures: [JSONAny]?
    let attributes: [Attribute]?
    let pictures: [Picture]?
    let parentID: String?
    let childrenIDS: [JSONAny]?
    let qualityType, priority, type: String?
    let variations: [JSONAny]?
    let siteID, keywords, description: String?
    
    var dateValue: Date? {
        return dateCreated?.toDateARG(formato: "yyyy-MM-dd'T'HH:mm:ssZ")
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case dateCreated = "date_created"
        case catalogProductID = "catalog_product_id"
        case pdpTypes = "pdp_types"
        case status
        case domainID = "domain_id"
        case settings, name
        case mainFeatures = "main_features"
        case attributes, pictures
        case parentID = "parent_id"
        case childrenIDS = "children_ids"
        case qualityType = "quality_type"
        case priority, type, variations
        case siteID = "site_id"
        case keywords, description
    }
    
}

struct Attribute: Codable {
    let id, name, valueID, valueName: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case valueID = "value_id"
        case valueName = "value_name"
    }
}

struct Picture: Codable {
    let id: String?
    let url: String?
}

struct Settings: Codable {
    let listingStrategy: String?
    let exclusive: Bool?
    
    enum CodingKeys: String, CodingKey {
        case listingStrategy = "listing_strategy"
        case exclusive
    }
}

