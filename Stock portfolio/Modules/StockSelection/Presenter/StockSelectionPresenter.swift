//
//  BuyStockPresenter.swift
//  Stock portfolio
//
//  Created by Yoni on 22/08/2020.
//  Copyright © 2020 Yoni. All rights reserved.
//

import Foundation

//BuyStockPresenter Protocol
protocol BuyStockPresenterDelegate{
    func reloadData()
}

class BuyStockPresenter{
    var buyStockPresenterDelegate:BuyStockPresenterDelegate!
    var industry = [Industry](){
        didSet{
            filterdIndustry = industry
        }
    }
    var filterdIndustry = [Industry]()
    
    init(buyStockPresenterDelegate: BuyStockPresenterDelegate) {
        self.buyStockPresenterDelegate = buyStockPresenterDelegate
        readFromLocalJson()
    }
    
    func readFromLocalJson(){
        if let path = Bundle.main.path(forResource: "stocks_names.list", ofType: ".json"){
            do{
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let object = try JSONDecoder().decode([StockElement].self, from: data)
                let stocksVM = object.map {StockVM(stockElement: $0)}
                
                for stock in  stocksVM{
                    let name = stock.industry
                    if !self.industry.contains(where: {$0.name == name}){
                        self.industry.append(Industry(name: name, stocks:[stock]))
                    }else{
                        var count = 0
                        self.industry.forEach {
                            if $0.name == name{
                                self.industry[count].stocks.append(stock)
                                self.industry[count].stocks.sort()
                                return
                            }
                            count += 1
                        }
                    }
                    self.industry.sort()
                    
                }
            }catch{
                print(error.localizedDescription)
            }
        }
        
    }
    
    func numberSections () -> Int{
        if filterdIndustry.count != 0{
            return filterdIndustry.count
        }
        return 0
    }
    
    func getSectionTitle(withSection index:Int) -> String?{
        if index < filterdIndustry.count{
            return filterdIndustry[index].name
        }else{
            return nil
        }
    }
    
    func numberRowsInSection(withSection index:Int) -> Int? {
        if index < filterdIndustry.count{
            return filterdIndustry[index].stocks.count
        }else{
            return nil
        }
    }
    
    func getStockVM(withSection section: Int ,AtRow row:Int) -> StockVM?{
        if section < filterdIndustry.count ,row < filterdIndustry[section].stocks.count{
            return filterdIndustry[section].stocks[row]
        }
        return nil
    }
    
    func getArrayStockVM(withSection section: Int ) -> [StockVM]?{
        if section < filterdIndustry.count{
            return filterdIndustry[section].stocks
        }
        return nil
    }
    
    
    func checkIfIsExpended (withSection section: Int) -> Bool?{
        if section < filterdIndustry.count{
            return filterdIndustry[section].isExpended
        }else{
            return nil
        }
    }
    
    func switchStatusIsExpended(withSection section: Int){
        if section < filterdIndustry.count{
            return filterdIndustry[section].isExpended = !filterdIndustry[section].isExpended
        }
    }
    
    func filterStockList(with text:String){
        if !text.isEmpty{
            filterdIndustry = industry.filter({$0.name.lowercased().contains(text.lowercased())})
        }else{
            filterdIndustry = industry
        }
        buyStockPresenterDelegate.reloadData()
    }
    
}
