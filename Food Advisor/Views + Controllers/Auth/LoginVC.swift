//
//  LoginVC.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2020-12-21.
//

import UIKit
import GoogleSignIn

class LoginVC: UIViewController {

    static let id = "LoginVC"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }
    
    @IBAction func didTapOnSignInWithGoogleButton(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
}
