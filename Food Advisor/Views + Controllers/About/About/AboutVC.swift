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
        gotoWebView(.PrivacyPolicy)
    }
    
    @IBAction func didTapOnTermsAndConditionsButton(_ sender: Any) {
        gotoWebView(.TermsAndConditions)
    }
    
    @IBAction func didTapOnMyBookingsButton(_ sender: Any) {
        AppNavigator.shared.pushToViewController(in: .About, for: MyBookingsVC.id, from: self)
    }
    
    @IBAction func didTapOnChatWithUsButton(_ sender: Any) {
        gotoWebView(.Messsenger)
    }
    
    @IBAction func didTapOnDeleteAccountButton(_ sender: Any) {
    }
    
    // MARK: IBActions
    @IBAction func didTapOnLogoutButton(_ sender: Any) {
        AlertVC.presentAlert(for: self,
                             title: "Logout",
                             message: "Are you sure to logout?",
                             left: "Yes",
                             right: "No") {
            GIDSignIn.sharedInstance().signOut()
            LocalUser.shared.removeAllData()
            AppNavigator.shared.manageUserDirection(window: UIApplication.shared.windows.first)
        } onRight: {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension AboutVC {
    private func configureView() {
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = false
    }
    
    private func gotoWebView(_ type: WebViewType) {
        let storyboard = UIStoryboard(name: Storyboard.About.rawValue, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: WebViewVC.id) as! WebViewVC
        vc.webViewType = type
        navigationController?.pushViewController(vc, animated: true)
    }
}
