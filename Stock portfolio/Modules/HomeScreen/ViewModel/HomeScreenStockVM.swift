//
//  HomeScreenStockVM.swift
//  Stock portfolio
//
//  Created by Yoni on 05/09/2020.
//  Copyright © 2020 Yoni. All rights reserved.
//

import Foundation

class HomeScreenStockVM{
    
    private let stock:Stock
    
    init(_ stock: Stock) {
        self.stock = stock
        
    }
    
    
    var amount: Int{
        stock.amount
    }
    
    var symbole: String{
        stock.symbole
    }
    
    var company: String{
        stock.name
    }
    
    
}
