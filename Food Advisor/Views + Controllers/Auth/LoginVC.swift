//
//  LoginVC.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2020-12-21.
//

import UIKit
import GoogleSignIn
import Lottie

class LoginVC: UIViewController {

    static let id = "LoginVC"
    
    @IBOutlet weak var logoView: AnimationView!
    @IBOutlet weak var signInView: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        animate()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }
    
    @IBAction func didTapOnSignInWithGoogleButton(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
}

extension LoginVC {
    private func animate() {
        logoView.contentMode = .scaleAspectFit
        logoView.loopMode = .loop
        logoView.play()
    }
    
    private func setupUI() {
        signInView.layer.cornerRadius = 16
        signInView.colorScheme = .dark
        signInView.style = .wide
    }
}
