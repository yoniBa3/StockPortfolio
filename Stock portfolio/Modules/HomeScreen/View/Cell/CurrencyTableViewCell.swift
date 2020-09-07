//
//  CurrencyTableViewCell.swift
//  Stock portfolio
//
//  Created by Yoni on 20/08/2020.
//  Copyright © 2020 Yoni. All rights reserved.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    
    //MARK: -Outlets
    @IBOutlet weak var nameAndSymboleLabel: UILabel!
    
    //MARK: -Properties
    public static let identifier = "CurrencyTableViewIdentifier"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: -Functions
    
    func configureCell(with data: CurrencyDataForTable){
        nameAndSymboleLabel.text = "\(data.symbole) \(data.namePlural) "
    }

}
