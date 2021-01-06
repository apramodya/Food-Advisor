//
//  AboutVC.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2020-12-21.
//

import UIKit
import GoogleSignIn

class AboutVC: UIViewController {

    // MARK: Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
    @IBAction func didTapOnPrivacyPolicyButton(_ sender: Any) {
    }
    
    @IBAction func didTapOnTermsAndConditionsButton(_ sender: Any) {
    }
    
    @IBAction func didTapOnMyBookingsButton(_ sender: Any) {
        AppNavigator.shared.pushToViewController(in: .About, for: MyBookingsVC.id, from: self)
    }
    
    @IBAction func didTapOnDeleteAccountButton(_ sender: Any) {
    }
    
    // MARK: IBActions
    @IBAction func didTapOnLogoutButton(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        LocalUser.shared.removeAllData()
        AppNavigator.shared.manageUserDirection()
    }
}

extension AboutVC {
    private func configureView() {
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = false
    }
}
