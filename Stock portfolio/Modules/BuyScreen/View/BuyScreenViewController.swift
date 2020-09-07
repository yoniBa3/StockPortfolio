//
//  BuyScreenViewController.swift
//  Stock portfolio
//
//  Created by Yoni on 26/08/2020.
//  Copyright © 2020 Yoni. All rights reserved.
//

import UIKit

class BuyScreenViewController: UIViewController {
    
    //MARK: -Outlets
    @IBOutlet weak var amountOfStocks: UITextField!
    @IBOutlet weak var stockSymbole: UILabel!
    @IBOutlet weak var stockPrice: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var marketKApLabel: UILabel!
    @IBOutlet weak var yourStockAmount: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var sumOfBuy: UILabel!
    @IBOutlet weak var buyButton: CustomButton!
    @IBOutlet weak var cancelButton: CustomButton!

    
    
    
    //MARK: -Propeties
    public static let identifier = "GoToBuyScreen"
    var stockVM:StockVM?
    private var stockDetail: StockDetaile?
    var bill: Double?
    var user:User!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        configurePage()
    }
    
    //MARK: -Actions
    @IBAction func homeButtonTapped(_ sender: Any) {
        Router.shared.goToHomeVC()
    }
    @IBAction func buyButtonTapped(_ sender: CustomButton) {
        sender.shakeButtomButton()
        
        if user.stocks.count == 6 && !user.stocks.contains(where: {$0.symbole == stockVM?.symbole}){
            showAlertController("Alert", "You can only have 5 differnt stocks please cell before you can buy another...")
        }else{
            validateBuy()
        }
    }
    @IBAction func cancelbuttonTapped(_ sender: CustomButton) {
        sender.shakeButtomButton()
        Router.shared.goToHomeVC()
    }
    @IBAction func startEditingTapped(_ sender: UITextField) {
        
        if let text = sender.text{
            sumOfBuy.isHidden = false
            if let amount = Int(text){
                if let price = stockDetail?.price?.regularMarketPrice?.raw{
                    sumOfBuy.text = "Cost: \(((Double(amount) * price) * (user.fromCurrency / user.toCurrency)).toString2Digits()) \(user.currencySymbole)"
                    
                }
            }
        }
    }
    
    
    
    //MARK: -Functions
    
    private func configurePage(){
        user = Utilities.shared.user
        configureParticals()
        loadDataFromAPI()
    }
    
    private func configureParticals(){
        buyButton.setupeButton()
        cancelButton.setupeButton()
        sumOfBuy.isHidden = true
        amountOfStocks.isEnabled = false
        if let symbole = stockVM?.symbole{
            stockSymbole.text = symbole
        }
    }
    
    private func loadDataFromAPI(){
        if let symbole = stockVM?.symbole{
            YahooFinance.shared.serverRequestWithStockStruct(with: symbole) { (stockDetail) in
                self.stockDetail = stockDetail
                self.showDataOfStock()
            }
        }
    }
    
    private func showDataOfStock(){
        amountOfStocks.isEnabled = true
        activityIndicator.stopAnimating()
        if let stockDetail = stockDetail{
            if let price = stockDetail.price?.regularMarketPrice?.raw{
                stockPrice.text = "Price: \((price * user.fromCurrency / user.toCurrency).toString2Digits()) \(user.currencySymbole)"
            }
            
            if let company = stockVM?.company{
                companyLabel.text = "Company: \(company)"
            }
            
            if let marketCap = stockDetail.price?.marketCap?.fmt{
                marketKApLabel.text = "MarketCap: \(marketCap)"
            }else{
                marketKApLabel.text = "MarketCap: N/A"
            }
        }
        var yourAmountOfStock = 0
        if let symbole = stockVM?.symbole{
            if let stock = Utilities.shared.user.stocks.first(where: {$0.symbole == symbole}){
                yourAmountOfStock = stock.amount
            }
        }
        yourStockAmount.text = "You Own:\(yourAmountOfStock)"
    }
    
    private func validateBuy(){
        if let textFromTextField = amountOfStocks.text{
            if let amount = Int(textFromTextField){
                let userCash = Utilities.shared.user.cash
                if let price = stockDetail?.price?.regularMarketPrice?.raw{
                    let bill = Double(amount) * price
                    if userCash < bill{
                        showAlertController("Alert", "You dont have enough Money to buy...")
                    }else{
                        UserDataBase.shared.buyStock(amount, stockSymbole: self.stockVM!.symbole, stockCompany: self.stockVM!.company, cost: bill) { (finish) in
                            if finish{
                                self.showAlertController("Congratulations", "You have purchased \(amount) \(self.stockVM!.symbole) stocks ")
                                UserDataBase.shared.getUserInformation(Utilities.shared.user.uId) { (finish) in
                                    if  let amountOfStocks = Utilities.shared.user.stocks.first(where: {$0.symbole == self.stockVM?.symbole})?.amount{
                                         self.yourStockAmount.text = "You Own: \(amountOfStocks)"
                                        self.amountOfStocks.text = ""
                                    }
                                   
                                }
                            }
                            
                        }
                    }
                }
            }
        }
    }
}

