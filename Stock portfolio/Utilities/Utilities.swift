//
//  Utilities.swift
//  Stock portfolio
//  Created by Yoni on 14/08/2020.
//  Copyright © 2020 Yoni. All rights reserved.
//

import Foundation


//MARK: -Singltone
class Utilities{
    
    public static let shared = Utilities()
    
    private init(){}
    
    //MARK: Properties
    
    var user:User = User(cash: 0, lastStockWorth: 0, firstName: "", lastName: "", uId: "", toCurrency: 1.0, fromCurrency: 1.0, currencySymbole: "", stocks: [])
    
    //MARK: -Functions For User Validation
    
    func isPasswordValide(_ password: String) -> Bool{
        let validPassword = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[0-9])(?=.*[A-Z]).{6,}$")
        return validPassword.evaluate(with: password)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let validEmail = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return validEmail.evaluate(with: email)
    }
    
    
    func isUserConnectedStatus(_ status: Bool){
        let defults = UserDefaults.standard
        defults.set(status, forKey: Constants.IsConnected.isConnected)
        if !status{
            defults.set(nil, forKey: Constants.IsConnected.userId)
        }
    }
    
    func checkIfUserConnected() -> String?{
        let defults = UserDefaults.standard
        return defults.string(forKey: Constants.IsConnected.userId)
    }
    
    func setUserId(_ uId: String){
        let defults = UserDefaults.standard
        defults.set(uId, forKey: Constants.IsConnected.userId)
    }
    
    
    
}
