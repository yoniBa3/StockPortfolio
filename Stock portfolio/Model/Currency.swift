//
//  Currency.swift
//  Stock portfolio
//
//  Created by Yoni on 18/08/2020.
//  Copyright © 2020 Yoni. All rights reserved.
//

import Foundation



struct Currency: Codable {
    let status, formula: String
    let currencyRates: [String: Double]

    enum CodingKeys: String, CodingKey {
        case status, formula
        case currencyRates = "currency_rates"
    }
}

struct CurrencyData:Codable{
    let symbol, namePlural, symbolNative: String
    let decimalDigits, rounding: Int

    enum CodingKeys: String, CodingKey {
        case symbol, namePlural
        case symbolNative = "symbol_native"
        case decimalDigits = "decimal_digits"
        case rounding
    }
}

typealias CurrencySymboles = [String: CurrencyData]

struct CurrencyDataForTable:Codable ,Comparable{
    
    var symbole:String
    var symboleNative: String
    var ExchangeRate:Double
    var namePlural:String
    
    static func < (lhs: CurrencyDataForTable, rhs: CurrencyDataForTable) -> Bool {
        lhs.ExchangeRate > rhs.ExchangeRate
    }
}

typealias CurrencyCodeDictionary = [String: CurrencyDataForTable]

