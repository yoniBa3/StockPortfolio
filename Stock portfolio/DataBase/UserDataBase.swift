//
//  UserDataBase.swift
//  Stock portfolio
//
//  Created by Yoni on 16/08/2020.
//  Copyright © 2020 Yoni. All rights reserved.
//

import Firebase


class UserDataBase{
    
    public static let shared = UserDataBase()
    private init(){
        
    }
    
    var db = Firestore.firestore()
    
    //MARK: -Functions
    
    func getUserInformation(_ uId: String ,complation:@escaping(Bool) ->()){
        var firstName = ""
        var lastName = ""
        var cash = 0.0
        var lastStockWorth = 0.0
        var toCurrency = 0.0
        var fromCurrency = 0.0
        var currencySymbole = ""
        db.collection("users").whereField("uId", isEqualTo: uId).getDocuments { (querySnapShot, error) in
            if let error = error{
                print("Error getting documents: \(error)")
                complation(false)
            }else{
                for document in querySnapShot!.documents{
                    firstName = document.data()["firstName"] as! String
                    lastName = document.data()["lastName"] as! String
                    cash = document.data()["cash"] as! Double
                    lastStockWorth = document.data()["lastStockWorth"] as! Double
                    toCurrency = document.data()["toCurrency"] as! Double
                    fromCurrency = document.data()["fromCurrency"] as! Double
                    currencySymbole = document.data()["currencySymbole"] as! String
                    
                    var stocks = [Stock]()
                    
                    self.db.collection("users").document(document.documentID).collection("stocks").getDocuments { (querySnapShot1, err) in
                        if let error = error{
                            print("Error getting documents: \(error)")
                            complation(false)
                        }else{
                            for document in querySnapShot1!.documents{
                                let stockName = document.data()["stockName"] as! String
                                let stockSymbole = document.data()["symbole"] as! String
                                let amount = document.data()["amount"] as! Int
                                stocks.append(Stock(name: stockName,symbole:stockSymbole , amount: amount))
                            }
                            Utilities.shared.user = User(cash: cash, lastStockWorth: lastStockWorth, firstName: firstName, lastName: lastName, uId: uId, toCurrency: toCurrency, fromCurrency: fromCurrency, currencySymbole: currencySymbole, stocks: stocks.sorted())
                            complation(true)
                        }
                    }
                }
            }
        }
        
    }
    
    func saveDataChangeInformation(_ uId: String , stockSymbole: String ,amount: Int ,stockName: String ,cash:Double
        ,complation:@escaping(Bool) ->()){
        db.collection("users").whereField("uId", isEqualTo: uId).getDocuments { (snapShot, err) in
            if let err = err{
                print(err.localizedDescription)
                complation(false)
            }else{
                if let document = snapShot?.documents[0] {
                    let id = document.documentID
                    let stocks = self.db.collection("users").document(id).collection("stocks")
                    self.db.collection("users").document(id).collection("stocks").whereField("symbole", isEqualTo: stockSymbole).getDocuments { (documents, err) in
                        if let err = err{
                            print(err.localizedDescription)
                            complation(false)
                        }else{
                            if documents?.count == 0{
                                stocks.addDocument(data: ["symbole": stockSymbole ,"amount" : amount ,"stockName":stockName])
                                complation(true)
                            }else{
                                if let stockId = documents?.documents[0].documentID{
                                    stocks.document(stockId).setData(["amount":amount], merge: true)
                                    complation(true)
                                }
                            }
                            self.db.collection("users").document(document.documentID).setData(["cash":cash], merge: true)
                        }
                    }
                }
            }
        }
    }
    
    func saveLastStockWorth(_ uId: String ,worth: Double ,complation:@escaping(Bool) -> ()){
        db.collection("users").whereField("uId", isEqualTo: uId).getDocuments { (documnets, err) in
            if let err = err{
                print(err.localizedDescription)
                complation(false)
            }else{
                if let document = documnets?.documents[0]{
                    self.db.collection("users").document(document.documentID).setData(["lastStockWorth":worth], merge: true)
                    complation(true)
                }
            }
        }
        
    }
    
    func buyStock(_ amountOfStock: Int ,stockSymbole: String ,stockCompany:String ,cost:Double ,complation:@escaping(Bool) -> ()){
        let user = Utilities.shared.user
        var amount = amountOfStock
        if let stock = user.stocks.first(where: {$0.symbole == stockSymbole}){
            amount += stock.amount
        }
        let newCach = user.cash - cost
        let lastStockWorth = user.lastStockWorth + cost
        saveLastStockWorth(user.uId, worth: lastStockWorth) { (finish) in
            
        }
        saveDataChangeInformation(user.uId, stockSymbole: stockSymbole, amount: amount, stockName: stockCompany, cash: newCach) { (finish) in
            if finish{
                complation(true)
            }else{
                complation(false)
            }
        }
    }
    
    func cellStocks(_ amountOfStock:Int ,_ stockSymbole: String ,_ stockCompany:String ,_ worth:Double ,complation:@escaping(Bool)->()){
        let user = Utilities.shared.user
        var amount = amountOfStock
        if let stock = user.stocks.first(where: {$0.symbole == stockSymbole}){
            amount = stock.amount - amount
        }
        let newCash = user.cash + worth
        let lastStockWorth = user.lastStockWorth - worth
        saveLastStockWorth(user.uId, worth: lastStockWorth) { (finish) in
            
        }
        saveDataChangeInformation(user.uId, stockSymbole: stockSymbole, amount: amount, stockName: stockCompany, cash: newCash) { (finish) in
            if finish{
                complation(true)
            }else{
                complation(false)
            }
        }
    }
    
    func changeToCurrency(toCurrency:Double ,curencySymbole:String ,comlation:@escaping() -> ()){
        let user = Utilities.shared.user
        let fromCurrency = user.fromCurrency
        Utilities.shared.user.fromCurrency = toCurrency
        Utilities.shared.user.toCurrency = fromCurrency
        db.collection("users").whereField("uId", isEqualTo: user.uId).getDocuments { (result, err) in
            if let err = err{
                print(err.localizedDescription)
            }
            else if let document = result?.documents[0]{
                self.db.collection("users").document(document.documentID).setData(["toCurrency":toCurrency ,"currencySymbole":curencySymbole ,"fromCurrency":fromCurrency], merge: true)
                self.getUserInformation(user.uId) { (finish) in
                    comlation()
                }
                
            }
        }
    }
    
}
