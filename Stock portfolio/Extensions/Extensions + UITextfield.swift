//
//  Extensions + UITextfield.swift
//  Stock portfolio
//
//  Created by Yoni on 12/08/2020.
//  Copyright © 2020 Yoni. All rights reserved.
//

import UIKit

extension UITextField{
    func setBottemBorder(){
        let bottomLine = CALayer()
        bottomLine.frame = .init(x: 0.0, y: self.frame.height, width: self.layer.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.darkGray.cgColor
        self.layer.addSublayer(bottomLine)
    }
    
    func setPadding(){
        let paddingView = UIView(frame: .init(x: 0, y: 0, width: 10, height: self.layer.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
        
    }
    
    func changePlaceHolderColor(){
        let color = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        let placeHolder = self.placeholder ?? ""
        self.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSAttributedString.Key.foregroundColor: color])
    }
}
