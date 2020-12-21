//
//  LoginVC.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2020-12-21.
//

import UIKit

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapOnLoginButton(_ sender: Any) {
        let token = "123-123"
        
        LocalUser.shared.token = token
        
        AppNavigator.shared.manageUserDirection()
    }
    
}
