//
//  Date + Extension.swift
//  ChallengeApp
//
//  Created by VILLAHERMOSA SEBASTIAN on 31/05/2025.
//

import Foundation

extension Date {
    func toStringARG(formato: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formato
        dateFormatter.locale = Locale(identifier: "es_AR")
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT-3:00")
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
}

extension String {
    func toDateARG(formato: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formato
        dateFormatter.locale = Locale(identifier: "es_AR")
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT-3:00")
        return dateFormatter.date(from: self)
    }
}
