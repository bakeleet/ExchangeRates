//
//  RESTCache.swift
//  ExchangeRates
//
//  Created by bakeleet on 24/06/2024.
//

import Foundation


struct RESTCache {

    private struct CacheEntry {
        var date: Date
        var response: Decodable
    }

    private var cachedEntries = [String: CacheEntry]()

    mutating func add(_ response: Decodable, from url: String) {
        cachedEntries[url] = CacheEntry(date: Date(), response: response)
    }

    func getRecentResponse(from url: String) -> Decodable? {
        guard let entry = cachedEntries[url] else { return nil }

        let now = Date()
        let responseDatePlus15Minut = entry.date.addingTimeInterval(900)

        if now <= responseDatePlus15Minut {
            return entry.response
        }

        return nil
    }
}
