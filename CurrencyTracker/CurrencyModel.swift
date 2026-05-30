//
//  CurrencyModel.swift
//  CurrencyTracker
//
//  Created by Maksim Shyshko on 30.05.2026.
//

import Foundation

struct CurrencyRate: Decodable {
    let name: String
    let rateIn: Double
    let rateOut: Double
}

struct CurrencyRatesResponse: Decodable {
    let rates: [CurrencyRate]

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let flatDictionary = try container.decode([String: String].self)

        var groupedRates: [String: (rateIn: Double?, rateOut: Double?)] = [:]

        for (key, valueString) in flatDictionary {
            let components = key.split(separator: "_")
            guard components.count == 2 else { continue }

            let currencyName = String(components[0])
            let type = String(components[1])
            let value = Double(valueString) ?? 0.0

            if type == "in" {
                groupedRates[currencyName, default: (nil, nil)].rateIn = value
            } else if type == "out" {
                groupedRates[currencyName, default: (nil, nil)].rateOut = value
            }
        }

        var parsedRates: [CurrencyRate] = []
        for (name, values) in groupedRates {
            if let rateIn = values.rateIn, let rateOut = values.rateOut {
                parsedRates.append(CurrencyRate(name: name, rateIn: rateIn, rateOut: rateOut))
            }
        }
        self.rates = parsedRates
    }
}

