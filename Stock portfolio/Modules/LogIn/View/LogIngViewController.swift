//
//  LogIngViewController.swift
//  Stock portfolio
//
//  Created by Yoni on 12/08/2020.
//  Copyright © 2020 Yoni. All rights reserved.
//

import UIKit
import Firebase

class LogIngViewController: UIViewController {
    
    //MARK: -Outlets
    @IBOutlet weak var stockImage: UIImageView!
    @IBOutlet weak var nameTextFiled: UITextField!
    @IBOutlet var textFileds: [UITextField]!
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet var buttonsArray: [UIButton]!
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var messageLabel: UILabel!
    
    
    //MARK: -Properties
    
    //MARK: -LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configurePage()
    }
    
    
    private func configurePage(){
        ConfigureParticalsOnScreen()
    }
    
    private func ConfigureParticalsOnScreen(){
        textFileds.forEach {$0.setBottemBorder();$0.setPadding(); $0.changePlaceHolderColor()}
        
        buttonsArray.forEach {
            $0.layer.cornerRadius = $0.frame.size.height / 2 }
        nameTextFiled.becomeFirstResponder()
        
        stockImage.layer.cornerRadius = 15
        messageLabel.alpha = 0
    }
    
    private func goToHomeViewController(){
        Router.shared.goToHomeVC()
    }
    
    private func validateTheFields() -> String?{
        if emailLabel.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordLabel.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "please fill all the fields"
        }
        return nil
        
    }
    
    private func showEror(_ message: String){
        messageLabel.alpha = 1
        messageLabel.text = message
        UIView.animate(withDuration: 10.0) {
            self.messageLabel.alpha = 0
        }
    }
    
    //MARK: -Actions
    
    @IBAction func signInTapped(_ sender: CustomButton) {
        sender.shakeButtomButton()
        //validate the filelds
        loadingActivityIndicator.startAnimating()
        if let message = validateTheFields(){
            showEror(message)
            loadingActivityIndicator.stopAnimating()
            return
        }
        
        let email = emailLabel.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordLabel.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
            if let err = err{
                self.showEror(err.localizedDescription)
                self.loadingActivityIndicator.stopAnimating()
            }else{
                Utilities.shared.isUserConnectedStatus(true)
                if let uid = result?.user.uid{
                    Utilities.shared.setUserId(uid)
                    UserDataBase.shared.getUserInformation(uid) { (finish) in
                        if finish{
                            self.loadingActivityIndicator.stopAnimating()
                            Router.shared.goToHomeVC()
                        }
                    }
                }
            }
        }
        
        
    }
    
    @IBAction func registerTapped(_ sender: CustomButton) {
        sender.shakeButtomButton()
    }
    
    
    
}

