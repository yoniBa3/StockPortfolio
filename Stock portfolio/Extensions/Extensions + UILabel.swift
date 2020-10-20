//
//  Extensions + UILabel.swift
//  Stock portfolio
//
//  Created by Yoni on 20/10/2020.
//  Copyright © 2020 Yoni. All rights reserved.
//

import UIKit

extension UILabel{
    
    func setup(with View:UIView ,and title: String ,point:CGPoint){
        self.frame = CGRect(x: 0, y: 0, width: View.bounds.width, height: 21)
        self.center = point
        self.text = title
        textAlignment = .center
        self.font = .boldSystemFont(ofSize: 21)
        View.addSubview(self)
    }
}
