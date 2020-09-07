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
        symcolLabel.text = stockVM.symbole
        companyLabel.text = stockVM.company
    }

}
