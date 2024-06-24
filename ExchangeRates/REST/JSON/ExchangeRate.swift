//
//  ExchangeRate.swift
//  ExchangeRates
//
//  Created by bakeleet on 24/06/2024.
//

import Foundation


struct ExchangeRate: Codable {

    var currency: String
    var code: String
    var mid: Float
}
