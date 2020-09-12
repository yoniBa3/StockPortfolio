//
//  SignUpAlertViewController.swift
//  Stock portfolio
//
//  Created by Yoni on 13/08/2020.
//  Copyright © 2020 Yoni. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class SignUpAlertViewController: UIViewController {
    
    //MARK: -Outlets
    @IBOutlet weak var alertView: UIView!
     @IBOutlet var textsFiled: [UITextField]!
    @IBOutlet weak var firstNameLabel: UITextField!
    @IBOutlet weak var lastNameLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var buttons: [UIButton]!
    
    //MARK: -Properties
    
    //MARK: -Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        configurePage()
    }
    
    //MARK: -Functions
    
    private func configurePage(){
        configureParticals()
    }
    
    private func configureParticals(){
        alertView.layer.cornerRadius = 20
        buttons.forEach {
            $0.layer.cornerRadius = $0.frame.size.height / 2
        }
        
        firstNameLabel.becomeFirstResponder()
        
        textsFiled.forEach {$0.setPadding();$0.setBottemBorder();$0.changePlaceHolderColor()}
        
        messageLabel.isHidden = true
        
        //buttons.forEach {$0.layer.cornerRadius = $0.frame.size.height / 2}
    }
    
    //check the filds if everthing is OK return nil otherwise rturn the error
    private func validateFileds() -> String?{
        messageLabel.isHidden = true
        if firstNameLabel.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameLabel.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailLabel.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordLabel.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill all the fields"
        }
        
        let email = emailLabel.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if !Utilities.shared.isValidEmail(email){
            return "Your email address is not valid "
        }
        
        let password = passwordLabel.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if !Utilities.shared.isPasswordValide(password){
            return "Please make sur that your password is min 6 char and one big letter and one digit "
        }
        
        return nil
    }
    
    private func showError(_ messgae: String){
        messageLabel.text = messgae
        messageLabel.isHidden = false
    }
    
    //MARK: -Actions
    @IBAction func cancel(_ sender: UIButton) {
         self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func registerTapped(_ sender: UIButton) {
        
        //Validate the fileds
        let errorMessage = validateFileds()
        
        if errorMessage != nil{
            showError(errorMessage!)
        }
        else{
            activityIndicator.startAnimating()
            let firstName = firstNameLabel.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameLabel.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailLabel.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordLabel.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                if let err = err{
                    self.showError(err.localizedDescription)
                }else{
                    
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: [
                        "firstName":firstName ,
                        "lastName": lastName ,
                        "uId": result!.user.uid ,
                        "cash": 100_000 ,
                        "toCurrency": 1.0 ,
                        "fromCurrency": 1.0,
                        "currencySymbole":"$",
                        "lastStockWorth": 0
                    ]).collection("stocks").addDocument(data: [
                        "amount": 0 ,
                        "stockName": "" ,
                        "symbole": ""
                        ])
                    { (err) in
                        if err != nil{
                            self.showError(err!.localizedDescription)
                        }else{
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                }
                self.activityIndicator.stopAnimating()
            }
        }
        
        
        
    }
    
    
    


}
