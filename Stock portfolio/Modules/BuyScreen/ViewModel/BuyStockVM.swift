//
//  BuyStockVM.swift
//  Stock portfolio
//
//  Created by Yoni on 17/09/2020.
//  Copyright © 2020 Yoni. All rights reserved.
//

import UIKit

class BuyStockVM {
    let stockDetaile: StockDetaile
    let stock: StockVM
    
    init(stockDetail: StockDetaile ,stock: StockVM){
        self.stockDetaile = stockDetail
        self.stock = stock
    }
    
    
    var priceForLabel:String {
       let currencyTupple = getCurrencyRatio()
        if let price = stockDetaile.price?.regularMarketPrice?.raw{
            let message = "Price: \((price * currencyTupple.ratio).toString2Digits()) \(currencyTupple.symbole)"
            return message
        }
        return "Price : N/A"
    }
    
    var userCash:Double{
        return Utilities.shared.user.cash
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
        if let marketCap = stockDetaile.price?.marketCap?.raw{
            let message = "MarketCap: \((Double(marketCap) * currencyTupple.ratio).roundedWithAbbreviations()) \(currencyTupple.symbole)"
            return message
        }
        return "MarketCap : N/A"
    }
    
    func getBillForLabel(amountOfStocks : Int) -> String{
        if amountOfStocks == 0{
            return ""
        }
        let currenyTupple = getCurrencyRatio()
        if let price = stockDetaile.price?.regularMarketPrice?.raw{
            let message = "Worth: \((price * Double(amountOfStocks) * currenyTupple.ratio).toString2Digits())\(currenyTupple.symbole)"
            return message
        }
        return ""
    }
    
    func getBill(_ amountOfStocks: Int) -> Double{
        if let price = stockDetaile.price?.regularMarketPrice?.raw{
            return price * Double(amountOfStocks)
        }
        else{
            return 0
        }
    }
    
    func getCurrencyRatio() -> (ratio:Double ,symbole:String){
        let user = Utilities.shared.user
        let ratio = user.fromCurrency / user.toCurrency
        let symbole = user.currencySymbole
        return (ratio ,symbole)
    }
}
