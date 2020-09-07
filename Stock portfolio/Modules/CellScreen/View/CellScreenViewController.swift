//
//  CellScreenViewController.swift
//  Stock portfolio
//
//  Created by Yoni on 01/09/2020.
//  Copyright © 2020 Yoni. All rights reserved.
//

import UIKit

class CellScreenViewController: UIViewController {
    //MARK: -Outlets
    @IBOutlet weak var stockSymboleLabel: UILabel!
    @IBOutlet weak var stockAmountTextField: UITextField!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var marketCapLabel: UILabel!
    @IBOutlet weak var yourAmountOfStocks: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var sumOfCellLabel: UILabel!
    @IBOutlet weak var cellButton: CustomButton!
    
    //MARK: -Properties
    public static let identifier = "GoToCellSegue"
    var stock:HomeScreenStockVM?
    var stockDetaile:StockDetaile?
    var userAmountOfStocks:Int?
    var bill:Double?
    var user: User!
    
    //MARK: -Lifecycle
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configurePage()
        
    }
    
    //MARK: -Actions
    @IBAction func homeButtonTapped(_ sender: Any) {
        Router.shared.goToHomeVC()
    }
    @IBAction func cellButtonTapped(_ sender: CustomButton) {
        sender.shakeButtomButton()
        validateCell()
        print("Tapped")
    }
    
    @IBAction func cancelButtonTapped(_ sender: CustomButton) {
        sender.shakeButtomButton()
    }
    
    @IBAction func editingDidChangeTapped(_ sender: UITextField) {
        if let text = sender.text{
            if !text.isEmpty{
                sumOfCellLabel.isHidden = false
                if let price = stockDetaile?.price?.regularMarketPrice?.raw{
                    if let amount = Int(text){
                        let bil = Double(amount) * price
                        self.bill = bil
                        print(bil.toString2Digits())
                        self.sumOfCellLabel.text = "Worth: \((bil * user.fromCurrency / user.toCurrency).toString2Digits()) \(user.currencySymbole)"
                    }
                }
            }else{
                sumOfCellLabel.isHidden = true
            }
        }
    }
    
    
    //MARK: -Functions

    private func configurePage(){
        sumOfCellLabel.isHidden = true
        stockAmountTextField.isEnabled = false
        cellButton.isEnabled = false
        user = Utilities.shared.user
    
        if let stock = stock{
            stockSymboleLabel.text = stock.symbole
            YahooFinance.shared.serverRequestWithStockStruct(with: stock.symbole) { (stockDetaile) in
                self.stockDetaile = stockDetaile
                self.showStockData()
            }
        }
    
    }
    
    private func showStockData(){
        activityIndicator.stopAnimating()
        stockAmountTextField.isEnabled = true
        cellButton.isEnabled = true
        if let stockDetaile = self.stockDetaile{
            if let price = stockDetaile.price?.regularMarketPrice?.raw{
                priceLabel.text = "Price: \((price * user.fromCurrency / user.toCurrency).toString2Digits()) \(user.currencySymbole)"
            }
            companyLabel.text = "Company: \(stock?.company ?? "N/A")"
            marketCapLabel.text = "MarketKap: \(stockDetaile.price?.marketCap?.fmt ?? "N/A")"
            var yourAmountOfStocks = 0
            if let stock = Utilities.shared.user.stocks.first(where: {$0.symbole == stock!.symbole}){
                yourAmountOfStocks = stock.amount
                self.userAmountOfStocks = stock.amount
            }
            self.yourAmountOfStocks.text = "You own: \(yourAmountOfStocks)"
        }
    }
    
    private func validateCell(){
        if let chosenAmountToCellText = stockAmountTextField.text{
            if let chosenAmountToCell = Int(chosenAmountToCellText){
                if let usersAmountOfStocks = self.userAmountOfStocks{
                    if usersAmountOfStocks == 0{
                        showAlertController("Alert", "You have to cell at list 1 stock")
                        return
                    }
                    if chosenAmountToCell > usersAmountOfStocks{
                        showAlertController("Alert", "You want to cell more stocks then you have")
                        
                    }else{
                        UserDataBase.shared.cellStocks(chosenAmountToCell, stock!.symbole, stock!.company, self.bill!) { (finish) in
                            if finish{
                                self.showAlertController("Congretulations", "You cell has been approved")
                                UserDataBase.shared.getUserInformation(Utilities.shared.user.uId) { (finish) in
                                    Router.shared.goToHomeVC()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    
    
    

}
