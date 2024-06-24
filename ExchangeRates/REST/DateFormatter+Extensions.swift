//
//  DateFormatter+Extensions.swift
//  ExchangeRates
//
//  Created by bakeleet on 24/06/2024.
//

import Foundation


extension DateFormatter {

    static let nbpFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
