//
//  StockVMTableViewCell.swift
//  Stock portfolio
//
//  Created by Yoni on 22/08/2020.
//  Copyright © 2020 Yoni. All rights reserved.
//

import UIKit

class StockVMTableViewCell: UITableViewCell {
    
    //MARK: -Outlets
    @IBOutlet weak var symcolLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    //MARK: -Properties
    public static let identifier = "StockCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: -Functions
    func configureCell(with stockVM : StockVM){
        symcolLabel.text = "Symbole: \(stockVM.symbole)"
        companyLabel.text = "Company: \(stockVM.company)"
        priceLabel.text = "Price: "
        activityIndicator.startAnimating()
    }
    
    func configureIfOpen(with stockVM : StockVM){
        
               YahooFinance.shared.serverRequestWithStockStruct(with: stockVM.symbole) { (result) in
                   self.activityIndicator.stopAnimating()
                   switch result{
                   case.success(let stockDetaile):
                       if let price = stockDetaile.price?.regularMarketPrice?.raw{
                           let currencyTupple = self.getCurrency()
                           self.priceLabel.text = "Price: \((price *  currencyTupple.rate).withSeperator())\(currencyTupple.symbole)"
                       }else{
                           self.priceLabel.text = "Price: N/A"
                       }
                       
                   case.failure(_):
                       self.priceLabel.text = "Price: N/A"
                   }
               }
    }
    
    func getCurrency() -> (rate: Double ,symbole:String){
        let user = Utilities.shared.user
        return (user.fromCurrency/user.toCurrency ,user.currencySymbole)
    }

}
