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
    
    public func manageUserDirection(window: UIWindow? = nil) {
        guard LocalUser.shared.getToken() != nil else {
            directToPath(window, in: .Auth, for: .Auth)
            return
        }
        
        directToPath(window, in: .Main, for: .Main)
    }
    
    private func directToPath(_ window: UIWindow?, in sb: Storyboard, for id: Storyboard) {
        let storyboard = UIStoryboard(name: sb.rawValue, bundle: nil)
        let topController = storyboard.instantiateViewController(withIdentifier: id.rawValue)

        window?.rootViewController = topController
        window?.makeKeyAndVisible()
    }
    
    public func pushToViewController(in sb: Storyboard, for identifier: String, from vc: UIViewController?, data: Any? = nil) {
        let storyboard = UIStoryboard(name: sb.rawValue, bundle: nil)
        let destVc = storyboard.instantiateViewController(withIdentifier: identifier)
        
        vc?.navigationController?.pushViewController(destVc, animated: true)
    }

}
