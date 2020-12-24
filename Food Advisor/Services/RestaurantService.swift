//
//  RestaurantService.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2020-12-25.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class RestaurantService {
    static let shared = RestaurantService()
    
}

// MARK: Fetch restauratns
extension RestaurantService {
    func fetchRestaurants(completion: @escaping (_ status: Bool, _ message: String, _ restaurants: [Restaurant]?) -> ()) {
        let collection = Firestore.firestore().collection("restaurants")
        
        collection.getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(false, error.localizedDescription, nil)
            } else {
                guard let documents = querySnapshot?.documents else {
                    completion(false, "Error", nil)
                    return
                }
                
                let restaurants = documents.compactMap({ (document) -> Restaurant? in
                    do {
                        return try document.data(as: Restaurant.self)
                    } catch {
                        completion(false, error.localizedDescription, nil)
                        return nil
                    }
                })
                
                completion(true, "Success", restaurants)
            }
        }
    }
}
