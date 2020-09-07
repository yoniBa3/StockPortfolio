//
//  Stock.swift
//  Stock portfolio
//
//  Created by Yoni on 22/08/2020.
//  Copyright © 2020 Yoni. All rights reserved.
//

import Foundation

struct Stock: Comparable{
    
    var name: String
    var symbole:String
    var amount: Int
    
    static func < (lhs: Stock, rhs: Stock) -> Bool {
        return lhs.name < rhs.name
    }
}

struct StockElement: Codable {
    let symbol, company, industry: String

    enum CodingKeys: String, CodingKey {
        case symbol = "Symbol"
        case company = "Company"
        case industry = "Industry"
    }
}

struct Industry : Comparable{
    
    var name:String
    var isExpended = false
    var stocks: [StockVM]
    static func < (lhs: Industry, rhs: Industry) -> Bool {
        lhs.name < rhs.name
    }
}




