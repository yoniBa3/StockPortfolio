//
//  LoadingViewController.swift
//  Stock portfolio
//
//  Created by Yoni on 16/08/2020.
//  Copyright © 2020 Yoni. All rights reserved.
//

import UIKit
import FirebaseDatabase



class LoadingViewController: UIViewController {
    
    //MARK: -Outlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var messageLabel: UILabel!
    
    //MARK: -Properties
    var ref: DatabaseReference!

    
    //MARK: -Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        configurePage()
    }
    

    //MARK: -Functions
    private func configurePage(){
        
        ref = Database.database().reference()
        if let userId = Utilities.shared.checkIfUserConnected(){
            messageLabel.text = "Retriving your data"
            UserDataBase.shared.getUserInformation(userId) { finish in
                self.activityIndicator.stopAnimating()
                Router.shared.goToHomeVC()
            }


        }
        else{
            Router.shared.goToLogIn()
        }
    }
}
