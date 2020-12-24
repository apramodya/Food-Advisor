//
//  AboutVC.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2020-12-21.
//

import UIKit

class AboutVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  
    @IBAction func didTapOnLogoutButton(_ sender: Any) {
        LocalUser.shared.removeAllData()
        
        print(LocalUser.shared.getToken())
        AppNavigator.shared.manageUserDirection()
    }
}
