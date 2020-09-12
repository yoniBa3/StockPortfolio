//
//  CellStockVM.swift
//  Stock portfolio
//
//  Created by Yoni on 11/09/2020.
//  Copyright © 2020 Yoni. All rights reserved.
//

import Foundation

class CellStockVM{
    let stockDetail: StockDetaile
    let stock: HomeScreenStockVM
    
    init(stockDetail: StockDetaile ,stock: HomeScreenStockVM) {
        self.stock = stock
        self.stockDetail = stockDetail
    }
    
    var priceForLabel:String {
       let currencyTupple = getCurrencyRatio()
        if let price = stockDetail.price?.regularMarketPrice?.raw{
            let message = "Price: \((price * currencyTupple.ratio).toString2Digits()) \(currencyTupple.symbole)"
            return message
        }
        return "Price : N/A"
    }
    
    var userAmountOfStocksForLabel: String{
        var yourAmountOfStocks = 0
        if let stock = Utilities.shared.user.stocks.first(where: {$0.symbole == self.stock.symbole}){
            yourAmountOfStocks = stock.amount
        }
        return "Your amount: \(yourAmountOfStocks)"
    }
    
    var userAmountOfStocks: Int{
        var yourAmountOfStocks = 0
        if let stock = Utilities.shared.user.stocks.first(where: {$0.symbole == self.stock.symbole}){
            yourAmountOfStocks = stock.amount
        }
        return yourAmountOfStocks
    }
    
    var company: String{
        return "Company: \(stock.company)"
    }
    
    var marketKap: String{
        let currencyTupple = getCurrencyRatio()
        if let marketCap = stockDetail.price?.marketCap?.raw{
            let message = "MarketCap: \((Double(marketCap) * currencyTupple.ratio).roundedWithAbbreviations()) \(currencyTupple.symbole)"
            return message
        }
        return "MarketCap : N/A"
    }
    
    func getCurrencyRatio() -> (ratio:Double ,symbole:String){
        let user = Utilities.shared.user
        let ratio = user.fromCurrency / user.toCurrency
        let symbole = user.currencySymbole
        return (ratio ,symbole)
    }
    
    
    func getBillForLabel(amountOfStocks : Int) -> String{
        if amountOfStocks == 0{
            return ""
        }
        let currenyTupple = getCurrencyRatio()
        if let price = stockDetail.price?.regularMarketPrice?.raw{
            let message = "Worth: \((price * Double(amountOfStocks) * currenyTupple.ratio).toString2Digits())\(currenyTupple.symbole)"
            return message
        }
        return ""
    }
    
    func getBill(_ amountOfStocks: Int) -> Double{
        if let price = stockDetail.price?.regularMarketPrice?.raw{
            return price * Double(amountOfStocks)
        }
        else{
            return 0
        }
    }
    
}
