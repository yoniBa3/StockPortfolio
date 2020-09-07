//
//  Router.swift
//  Stock portfolio
//
//  Created by Yoni on 15/08/2020.
//  Copyright © 2020 Yoni. All rights reserved.
//

import UIKit

class Router{
    public static let shared = Router()
    private init(){}
    
    var window: UIWindow?
    
    func goToLogIn(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let LoginVC = storyBoard.instantiateViewController(identifier: Constants.StoryBoard.logInViewController) as? LogIngViewController
        window!.rootViewController = LoginVC
        window!.makeKeyAndVisible()
    }
    
    
    func goToHomeVC(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let nav = UINavigationController()
        let homeViewController = storyBoard.instantiateViewController(withIdentifier: Constants.StoryBoard.homeViewController) as! HomeViewController
        nav.viewControllers.append(homeViewController)
        window!.rootViewController = nav
        window!.makeKeyAndVisible()
    }
}
