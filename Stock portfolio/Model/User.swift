//
//  User.swift
//  Stock portfolio
//
//  Created by Yoni on 16/08/2020.
//  Copyright © 2020 Yoni. All rights reserved.
//

import Foundation

struct User {
    
    var cash:Double
    var lastStockWorth: Double
    var firstName: String
    var lastName: String
    var uId: String
    var toCurrency:Double
    var fromCurrency:Double
    var currencySymbole:String
    var stocks: [Stock]
    
}


