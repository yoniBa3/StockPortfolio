//
//  Extensions + UIActivityIndicator.swift
//  Stock portfolio
//
//  Created by Yoni on 05/09/2020.
//  Copyright © 2020 Yoni. All rights reserved.
//

import UIKit

extension UIActivityIndicatorView{
    func setup(_ view:UIView){
        self.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 2)
        self.style = .large
        self.color = .black
        self.startAnimating()
        self.hidesWhenStopped = true
        view.addSubview(self)
        
    }
}
