//
//  LocalUser.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2020-12-21.
//

import Foundation

class LocalUser {
    static let shared = LocalUser()
    
    var user: User?
}

extension LocalUser {
    func removeAllData(){
        UserDefaults.standard.removeObject(forKey: "token")
    }
    
    func setToken(token: String) {
        UserDefaults.standard.set(token, forKey: "token")
    }
    
    func getToken() -> String? {
        return UserDefaults.standard.string(forKey: "token")
    }
    
    func setFirstName(name: String) {
        UserDefaults.standard.set(name, forKey: "name")
    }
    
    func getFirstName() -> String? {
        return UserDefaults.standard.string(forKey: "name")
    }
}
