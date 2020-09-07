//
//  Extensions + UIAlertController.swift
//  Stock portfolio
//
//  Created by Yoni on 01/09/2020.
//  Copyright © 2020 Yoni. All rights reserved.
//

import UIKit

extension UIViewController{
    func showAlertController(_ title:String ,_ message:String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .cancel) { (alertAction) in
            return
        }
        
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
}
