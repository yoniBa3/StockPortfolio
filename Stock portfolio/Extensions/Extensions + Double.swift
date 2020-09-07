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
}
