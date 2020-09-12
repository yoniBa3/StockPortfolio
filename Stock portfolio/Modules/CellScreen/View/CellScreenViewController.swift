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
    var cellStockVM: CellStockVM!
    
    //MARK: -Lifecycle
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configurePage()
        
    }
    
    //MARK: -Actions
    @IBAction func homeButtonTapped(_ sender: Any) {
        Router.shared.goToHomeVC()
    }
    @IBAction func cellButtonTapped(_ sender: CustomButton) {
        sender.shakeButtomButton()
        validateCell()
    }
    
    @IBAction func cancelButtonTapped(_ sender: CustomButton) {
        sender.shakeButtomButton()
        Router.shared.goToHomeVC()
    }
    
    @IBAction func editingDidChangeTapped(_ sender: UITextField) {
        if let text = sender.text{
            if !text.isEmpty{
                sumOfCellLabel.isHidden = false
                if let amount = Int(text){
                    self.sumOfCellLabel.text = cellStockVM.getBillForLabel(amountOfStocks: amount)
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
        configureBackButton()
    
        if let stock = stock{
            stockSymboleLabel.text = stock.symbole
            YahooFinance.shared.serverRequestWithStockStruct(with: stock.symbole) { (stockDetaile) in
                self.cellStockVM = CellStockVM(stockDetail: stockDetaile, stock: stock)
                self.showStockData()
            }
        }
    
    }
    
    private func configureBackButton(){
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goHome))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func goHome(){
        Router.shared.goToHomeVC()
    }
    
    private func showStockData(){
        activityIndicator.stopAnimating()
        stockAmountTextField.isEnabled = true
        cellButton.isEnabled = true
        priceLabel.text = cellStockVM.priceForLabel
        companyLabel.text = cellStockVM.company
        marketCapLabel.text = cellStockVM.marketKap
        yourAmountOfStocks.text = cellStockVM.userAmountOfStocksForLabel
            
    }
    
    private func validateCell(){
        if let chosenAmountToCellText = stockAmountTextField.text{
            if let chosenAmountToCell = Int(chosenAmountToCellText){
                if cellStockVM.userAmountOfStocks == 0{
                        showAlertController("Alert", "You have to cell at list 1 stock")
                        return
                    }
                    if chosenAmountToCell > cellStockVM.userAmountOfStocks{
                        showAlertController("Alert", "You want to cell more stocks then you have")
                        
                    }else{
                        let bill = cellStockVM.getBill(chosenAmountToCell)
                        self.activityIndicator.startAnimating()
                        UserDataBase.shared.cellStocks(chosenAmountToCell, stock!.symbole, stock!.company, bill) { (finish) in
                            if finish{
                                self.activityIndicator.stopAnimating()
                                self.showAlertController("Congretulations", "You cell has been approved")
                                UserDataBase.shared.getUserInformation(Utilities.shared.user.uId) { (finish) in
                                    self.yourAmountOfStocks.text = self.cellStockVM.userAmountOfStocksForLabel
                                    self.stockAmountTextField.text = ""
                                }
                            }
                    }
                }
            }else{
                showAlertController("Alert", "You have enterd an invalid value")
            }
        }
    }
    
    
}
