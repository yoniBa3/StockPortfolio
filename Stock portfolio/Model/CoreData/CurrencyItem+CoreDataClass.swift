//
//  CurrencyItem+CoreDataClass.swift
//  Stock portfolio
//
//  Created by Yoni on 03/10/2020.
//  Copyright © 2020 Yoni. All rights reserved.
//
//

import Foundation
import CoreData

@objc(CurrencyItem)
public class CurrencyItem: NSManagedObject {
    
    convenience init(symbole:String ,symboleNative:String ,exchnageRate: Double ,namePlural:String) {
        self.init(context: PersistenceManger.shared.context)
        self.symbole = symbole
        self.symboleNative = symboleNative
        self.exchangeRate = exchnageRate
        self.namePlural = namePlural
    }
}
