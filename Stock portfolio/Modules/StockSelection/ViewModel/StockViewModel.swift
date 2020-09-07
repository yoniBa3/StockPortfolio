//
//  BuyStockViewModel.swift
//  Stock portfolio
//
//  Created by Yoni on 22/08/2020.
//  Copyright © 2020 Yoni. All rights reserved.
//

import UIKit

class StockVM : Comparable{
    static func == (lhs: StockVM, rhs: StockVM) -> Bool {
        lhs.company < rhs.company
    }
    
    static func < (lhs: StockVM, rhs: StockVM) -> Bool {
        lhs.company < rhs.company
    }
    
    
    private let stockElement:StockElement
    
    init(stockElement: StockElement) {
        self.stockElement = stockElement
    }
    
    var company: String {
        return stockElement.company
    }
    
    var industry:String{
        stockElement.industry
    }
    
    var symbole:String{
        stockElement.symbol
    }
    
}
