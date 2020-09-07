//
//  UserStockTableViewCell.swift
//  Stock portfolio
//
//  Created by Yoni on 25/08/2020.
//  Copyright © 2020 Yoni. All rights reserved.
//

import UIKit

class UserStockTableViewCell: UITableViewCell {
    
    //MARK: -Outlets
    @IBOutlet weak var stockSymbole: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    //MARK: -Properties
    public static let identifier = "StockCellIdentifier"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(with stock:HomeScreenStockVM){
        stockSymbole.text = stock.symbole
        amountLabel.text = "amount: \(stock.amount)"
        companyLabel.text = stock.company
    }

}
