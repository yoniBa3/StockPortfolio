//
//  Extensions + Double.swift
//  Stock portfolio
//
//  Created by Yoni on 01/09/2020.
//  Copyright © 2020 Yoni. All rights reserved.
//

import Foundation

extension Double{
    
    func toString2Digits() ->String{
        String(format: "%.2f", self)
    }
    
    func roundedWithAbbreviations() -> String{
        let million = self / 1_000_000
        let billion = self / 1_000_000_000
        if billion >= 1.0{
            return "\(billion.toString2Digits())B"
        }else{
            return "\(million.toString2Digits())M"
        }
    }
}
