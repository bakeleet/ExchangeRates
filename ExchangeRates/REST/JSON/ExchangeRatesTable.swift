//
//  ExchangeRatesTable.swift
//  ExchangeRates
//
//  Created by bakeleet on 24/06/2024.
//

import Foundation


struct ExchangeRatesTable: Codable {

    var table: String
    var no: String
    var effectiveDate: Date
    var rates: [ExchangeRate]
}
