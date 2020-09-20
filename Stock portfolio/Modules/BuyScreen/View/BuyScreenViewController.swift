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
    var buyStockVM: BuyStockVM!
    
    //MARK: -Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        navigationController?.popViewController(animated: true)
    }
    @IBAction func startEditingTapped(_ sender: UITextField) {
        
        if let text = sender.text{
            if !text.isEmpty{
                sumOfBuy.isHidden = false
                if let amount = Int(text){
                    self.sumOfBuy.text = buyStockVM.getBillForLabel(amountOfStocks: amount)
                }
            }else{
                sumOfBuy.isHidden = true
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
        if let stock = stockVM{
            YahooFinance.shared.serverRequestWithStockStruct(with: stock.symbole) { (result) in
                switch result{
                case.failure(let description):
                    if let description = description{
                        self.showAlertController("Alert", description)
                    }
                case.success(let stockDetaile):
                    self.buyStockVM = BuyStockVM(stockDetail: stockDetaile, stock: stock)
                    self.showDataOfStock()
                }
            }
        }
    }
    
    private func showDataOfStock(){
        amountOfStocks.isEnabled = true
        activityIndicator.stopAnimating()
        stockPrice.text = buyStockVM.priceForLabel
        companyLabel.text = buyStockVM.company
        marketKApLabel.text = buyStockVM.marketKap
        yourStockAmount.text = buyStockVM.userAmountOfStocksForLabel
        
    }
    
    private func validateBuy(){
        if let chosenAmountStockToBuy = amountOfStocks.text{
            if let amount = Int(chosenAmountStockToBuy){
                if buyStockVM.userCash < buyStockVM.getBill(amount){
                    showAlertController("Alert", "You dont have enough Money to buy...")
                }else{
                    UserDataBase.shared.buyStock(amount, stockSymbole: self.stockVM!.symbole, stockCompany: self.stockVM!.company, cost: buyStockVM.getBill(amount)) { (finish) in
                        if finish{
                            self.showAlertController("Congratulations", "You have purchased \(amount) \(self.stockVM!.symbole) stocks ")
                            UserDataBase.shared.getUserInformation(Utilities.shared.user.uId) { (finish) in
                                self.yourStockAmount.text = self.buyStockVM.userAmountOfStocksForLabel
                                self.amountOfStocks.text = ""
                            }
                        }
                    }
                }
            }
        }
    }
    
}

