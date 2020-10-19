//
//  CurrencyItem+CoreDataProperties.swift
//  Stock portfolio
//
//  Created by Yoni on 03/10/2020.
//  Copyright © 2020 Yoni. All rights reserved.
//
//

import Foundation
import CoreData


extension CurrencyItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrencyItem> {
        return NSFetchRequest<CurrencyItem>(entityName: "CurrencyItem")
    }

    @NSManaged public var symbole: String
    @NSManaged public var symboleNative: String
    @NSManaged public var exchangeRate: Double
    @NSManaged public var namePlural: String

}
