//
//  AppNavigator.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2020-12-21.
//

import UIKit

enum Storyboard: String {
    case Auth
    case Main
    case Forum
    case About
}

class AppNavigator {
    static let shared = AppNavigator()
    
    public func manageUserDirection(window: UIWindow?) {
        guard LocalUser.shared.getToken() != nil else {
            gotoLogin(window)
            return
        }
        
        directToPath(window, in: .Main, for: .Main)
    }
    
    private func directToPath(_ window: UIWindow?, in sb: Storyboard, for id: Storyboard) {
        let storyboard = UIStoryboard(name: sb.rawValue, bundle: nil)
        let topController = storyboard.instantiateViewController(withIdentifier: id.rawValue)
        topController.navigationController?.navigationBar.isHidden = true
        window?.rootViewController = UINavigationController(rootViewController: topController)
        window?.rootViewController?.navigationController?.navigationBar.isHidden = true
        window?.makeKeyAndVisible()
    }
    
    private func gotoLogin(_ window: UIWindow?) {
        let storyboard = UIStoryboard(name: Storyboard.Auth.rawValue, bundle: nil)
        let topController = storyboard.instantiateViewController(withIdentifier: LoginVC.id) as! LoginVC
        
        window?.rootViewController = topController
        window?.rootViewController?.navigationController?.navigationBar.isHidden = true
        window?.makeKeyAndVisible()
    }
    
    public func pushToViewController(in sb: Storyboard, for identifier: String, from vc: UIViewController?, data: Any? = nil) {
        let storyboard = UIStoryboard(name: sb.rawValue, bundle: nil)
        let destVc = storyboard.instantiateViewController(withIdentifier: identifier)
        
        vc?.navigationController?.pushViewController(destVc, animated: true)
    }

}
