//
//  AboutVC.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2020-12-21.
//

import UIKit
import GoogleSignIn

class AboutVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
  
    @IBAction func didTapOnLogoutButton(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        LocalUser.shared.removeAllData()
        AppNavigator.shared.manageUserDirection()
    }
}
