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
        let trilion = self / 1_000_000_000_000
        if trilion >= 1.0{
            return "\(trilion.toString2Digits())T"
        }
        if billion >= 1.0{
            return "\(billion.toString2Digits())B"
        }else{
            return "\(million.toString2Digits())M"
        }
    }
}

extension Formatter{
    public static let withSeperator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        return formatter
    }()
}

extension Numeric{
    func withSeperator() -> String{
        Formatter.withSeperator.string(for: self) ?? ""
    }
}
extension String{
    func toStringDigits() -> String{
       String(format: "%.2f", self)
    }
}
