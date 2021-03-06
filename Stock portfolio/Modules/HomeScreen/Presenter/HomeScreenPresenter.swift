//
//  HomeScreenPresenter.swift
//  Stock portfolio
//
//  Created by Yoni on 05/09/2020.
//  Copyright © 2020 Yoni. All rights reserved.
//

//MARK: -HomeScreenPresenterDelegate
protocol HomeScreenPresenterDelegate {
    func loadCurrencyTable()
    func loadStockTable()
    func showUserMoneyAmount(_ moneyAmount: String ,_ currencySymbole: String ,_ statusAcount: AcountStatus)
    func refreshUserMoneyAmountInDifferentCurency(_ moneyAmount: String , _ currencySymbole: String)
    func showInformation(_ title: String ,_ message:String)
    func setNavigatorTitle(_ title:String)
    func checkIfUserHasNoStocks(_ title:String)
}

import Foundation
//MARK: -Presenter
class HomeScreenPresenter{
    
    //MARK: -Properties
    
    //delegate
    var delgate: HomeScreenPresenterDelegate

    //Stocks
    var homeScreenStockVM = [HomeScreenStockVM]()
    
    var userStocks = [(stockDetaile:StockDetaile ,amount:Int)](){
        didSet{
            if userStocks.count == homeScreenStockVM.count{
                self.checkUserMoneyAcount()
            }
        }
    }
    
    var chosenStock: HomeScreenStockVM?
    
    //Currencies
    var curreciesWithSymboles:CurrencySymboles = [:] {
        didSet{
            self.loadDataForCurrenciesTable()
        }
    }
    var currenciesCode = [(code:String,value:Double)](){
        didSet{
            filterdCurrenciesCode = currenciesCode
        }
    }
    var filterdCurrenciesCode = [(code:String,value:Double)](){
        didSet{
            delgate.loadCurrencyTable()
        }
    }
    var currenciesDictionary:CurrencyCodeDictionary = [:]
    
    
    
    //MARK: -Constractor
    init(delegate: HomeScreenPresenterDelegate) {
        self.delgate = delegate
        configurePresenter()
        let title = Utilities.shared.user.firstName
        let fullTittle = "\(title)'s portfoliio"
        delegate.setNavigatorTitle(fullTittle)
        
    }
    
    //Functions
    
    private func configurePresenter(){
        loadTableStockData()
        readLocalCurrencyJson()
    }
    
    //Stocks Functions
     func loadTableStockData(){
        let user = Utilities.shared.user
        if user.stocks.count == 1 {
            let userCash = (user.cash * user.fromCurrency / user.toCurrency).withSeperator()
            delgate.showUserMoneyAmount(userCash, user.currencySymbole, .positive)
            return
        }
        self.homeScreenStockVM = user.stocks.filter{$0.name != ""}.map{HomeScreenStockVM($0)}
        loadUserStockForTable()
        
    }
    
    private func loadUserStockForTable(){
        for stockVM in self.homeScreenStockVM{
            let symbole = stockVM.symbole
            YahooFinance.shared.serverRequestWithStockStruct(with: symbole) { (result) in
                switch result{
                case.failure(let description):
                    if let description = description{
                        self.delgate.showInformation("Error", description)
                    }
                case.success(let stockDetaile):
                    self.userStocks.append((stockDetaile ,stockVM.amount))
                }
            }
        }
    }
    
    private func checkUserMoneyAcount(){
        let lastStockWorth = Utilities.shared.user.lastStockWorth
        var newStockWorth: Double = 0.0
        for userStock in userStocks{
            if let stockWorth = userStock.stockDetaile.price?.regularMarketPrice?.raw{
                newStockWorth += stockWorth * Double(userStock.amount)
            }
        }
        var statusAcount: AcountStatus
        if lastStockWorth > newStockWorth{
            statusAcount = .negative
        }
        else if lastStockWorth < newStockWorth{
            statusAcount = .positive
        }
        else{
            statusAcount = .noChange
        }
        
        let user = Utilities.shared.user
        
        UserDataBase.shared.saveLastStockWorth(user.uId, worth: newStockWorth) { (_) in
        }
        let moneyAmount = ((user.cash + newStockWorth) * user.fromCurrency / user.toCurrency).withSeperator()
        delgate.showUserMoneyAmount(moneyAmount, user.currencySymbole, statusAcount)
        
        
    }
    
    func getUserStocksNumberOfRows() -> Int{
        if homeScreenStockVM.count == 0{
            delgate.checkIfUserHasNoStocks("Your list is empty , Please buy stocks")
        }
        return homeScreenStockVM.count
    }
    
    func getHomeScreenStockVM(atIndex index:Int) -> HomeScreenStockVM?{
        if homeScreenStockVM.count > index{
            return homeScreenStockVM[index]
        }
        return nil
    }
    
    
    func setUserStockSelection(atIndex index: Int) {
        if homeScreenStockVM.count > index {
            chosenStock = homeScreenStockVM[index]
        }
    }
    
    
    
    //Currencies Functions
    
    private func readLocalCurrencyJson(){
        if let path = Bundle.main.path(forResource: "CurrencySimbols", ofType: ".json"){
            do{
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let object = try JSONDecoder().decode([String: CurrencyData].self, from: data)
                self.curreciesWithSymboles = object
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    
    private func loadDataForCurrenciesTable(){
        CurrencyValue.shared.serverRequestWithCurrencyStruct { (result) in
            switch result{
            case.failure(_):
                self.loadCurrenciesDataFromCoreData()
            case.success(let currencyFromServer):
                var currencyCodeArray: CurrencyCodeDictionary = [:]
                for currency in currencyFromServer.currencyRates{
                    if let temp = self.curreciesWithSymboles[currency.key]{
                        self.currenciesCode.append((currency.key ,currency.value))
                        currencyCodeArray[currency.key] = CurrencyDataForTable(symbole: temp.symbol, symboleNative: temp.symbolNative, ExchangeRate: currency.value, namePlural: temp.namePlural)
                    }
                }
                self.currenciesDictionary = currencyCodeArray
                self.currenciesCode.sort {$0.1 > $1.1}
                
                self.updateCurrencyItemsInCoreData(currencyFromServer: currencyFromServer)
            }
            
        }
    }
    
    
    private func loadCurrenciesDataFromCoreData(){
        let currencyItems = PersistenceManger.shared.fetch(CurrencyItem.self)
        if currencyItems.count != 0 {
            var currencyCodeArray: CurrencyCodeDictionary = [:]
            for curency in currencyItems{
                self.currenciesCode.append((curency.symbole, curency.exchangeRate))
                currencyCodeArray[curency.symbole] = CurrencyDataForTable(symbole: curency.symbole, symboleNative: curency.symboleNative, ExchangeRate: curency.exchangeRate, namePlural: curency.namePlural)
            }
            self.currenciesDictionary = currencyCodeArray
            self.currenciesCode.sort {$0.1 > $1.1}
        }else{
            self.delgate.showInformation("Error", "There is no currency data to present")
            self.delgate.loadCurrencyTable()
        }
      
    }
    
    private func updateCurrencyItemsInCoreData(currencyFromServer:Currency){
        let currenciyItems = PersistenceManger.shared.fetch(CurrencyItem.self)
        if currenciyItems.count != 0{
            for currency in currencyFromServer.currencyRates{
                guard let item = currenciyItems.first(where: {$0.symbole == currency.key})else{continue}
                item.exchangeRate = currency.value
            }
        }else{
            for currency in currencyFromServer.currencyRates{
                if let temp = self.curreciesWithSymboles[currency.key]{
                    let _ = CurrencyItem(symbole: temp.symbol, symboleNative: temp.symbolNative, exchnageRate: currency.value, namePlural: temp.namePlural)
                }
            }
        }
        PersistenceManger.shared.saveContext()
        
    }
    
    func getCurrenciesNumberOfRows() -> Int{
        filterdCurrenciesCode.count
    }
    
    func getCurrencyDataForTable(atIndex index: Int) -> CurrencyDataForTable?{
        if filterdCurrenciesCode.count > index {
            let code = filterdCurrenciesCode[index].code
            return currenciesDictionary[code]
        }
        return nil
    }
    
    func changeUserCurrency(atIndex index:Int){
        if filterdCurrenciesCode.count > index{
            let code = filterdCurrenciesCode[index].code
            let currency = currenciesDictionary[code]!
            UserDataBase.shared.changeToCurrency(toCurrency: currency.ExchangeRate, curencySymbole: currency.symboleNative) {
                let user = Utilities.shared.user
                let moneyAmount = ((user.cash + user.lastStockWorth) * user.fromCurrency / user.toCurrency).withSeperator()
                self.delgate.refreshUserMoneyAmountInDifferentCurency(moneyAmount, user.currencySymbole)
            }
        }
        
    }
    
    func filterCurrencyTable(withText text:String){
        if !text.isEmpty{
            filterdCurrenciesCode = currenciesCode.filter({$0.code.lowercased().contains(text.lowercased())})
        }else{
            filterdCurrenciesCode = currenciesCode
        }
        
        delgate.loadCurrencyTable()
    }
    
    
    func showFullBalanceInAlert(){
        let user = Utilities.shared.user
        let currencyRatio = user.fromCurrency / user.toCurrency
        let cash = user.cash * currencyRatio
        let stockWorth = user.lastStockWorth * currencyRatio
        let messgae = "Your liquid cash is: \(cash.withSeperator())\(user.currencySymbole). \n Your stocks worth is:  \(stockWorth.withSeperator())\(user.currencySymbole)."
        delgate.showInformation("Full Balance", messgae)
    }
}

