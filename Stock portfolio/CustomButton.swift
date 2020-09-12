//
//  CustomButton.swift
//  Stock portfolio
//
//  Created by Yoni on 12/08/2020.
//  Copyright © 2020 Yoni. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupeButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupeButton()
    }
    
    func setupeButton() {
         setShadow()
         setRadius()
        
    }
    
    private func setShadow(){
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        layer.shadowRadius = 9
        layer.shadowOpacity = 0.5
        clipsToBounds = true
        layer.masksToBounds = false
    }
    
    private func setRadius(){
        layer.cornerRadius = layer.frame.size.height / 2
    }
    
    
     func shakeButtomButton(){
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 8, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 8, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: "position")
    }
}

