//
//  ExpandableHeaderFooterView.swift
//  Stock portfolio
//
//  Created by Yoni on 22/08/2020.
//  Copyright © 2020 Yoni. All rights reserved.
//

import UIKit
protocol ExpendableHeaderFooterViewDelegate{
    func toggleSection(header: ExpendableHeaderFooterView ,section:Int)
}

class ExpendableHeaderFooterView: UITableViewHeaderFooterView {

    //MARK: -Properties
    private var delegate:ExpendableHeaderFooterViewDelegate?
    private var section: Int!
    var isExpended = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel?.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        contentView.backgroundColor = #colorLiteral(red: 0.3529411765, green: 0.7843137255, blue: 0.9803921569, alpha: 1)
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selcectHeaderAction)))
    }
    
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     //MARK: -Functions
    
    func setHeaderFooterView(title: String ,section:Int ,delegate: ExpendableHeaderFooterViewDelegate){
        textLabel?.text = title
        self.section = section
        self.delegate = delegate
    }
    
    @objc func selcectHeaderAction(gesture: UITapGestureRecognizer){
        let cell = gesture.view as! ExpendableHeaderFooterView
        delegate?.toggleSection(header: self, section: cell.section)
    }
    
}

