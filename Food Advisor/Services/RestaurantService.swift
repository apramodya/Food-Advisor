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

// MARK: Fetch restaurants
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
                        debugPrint(error)
                        completion(false, error.localizedDescription, nil)
                        return nil
                    }
                })
                
                completion(true, "Success", restaurants)
            }
        }
    }
}

// MARK: Fetch restaurant
extension RestaurantService {
    func fetchRestaurant(for id: String, completion: @escaping (_ status: Bool, _ message: String, _ restaurant: Restaurant?) -> ()) {
        let document = Firestore.firestore().collection("restaurants").document(id)
        
        document.getDocument { (documentSnapshot, error) in
            if let error = error {
                completion(false, error.localizedDescription, nil)
            } else {
                
            }
        }
    }
}

// MARK: Fetch meals for restaurant
extension RestaurantService {
    func fetchMealsForRestaurant(for id: String, completion: @escaping (_ status: Bool, _ message: String, _ restaurants: [Meal]?) -> ()) {
        let collection = Firestore.firestore().collection("restaurants").document(id).collection("meals")
        
        collection.getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(false, error.localizedDescription, nil)
            } else {
                guard let documents = querySnapshot?.documents else {
                    completion(false, "Error", nil)
                    return
                }
                
                let meals = documents.compactMap({ (document) -> Meal? in
                    do {
                        return try document.data(as: Meal.self)
                    } catch {
                        debugPrint(error)
                        completion(false, error.localizedDescription, nil)
                        return nil
                    }
                })
                
                completion(true, "Success", meals)
            }
        }
    }
}
