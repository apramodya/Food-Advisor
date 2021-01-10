//
//  RestaurantReviews.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2021-01-09.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class RestaurantReviewsService {
    static let shared = RestaurantReviewsService()
}

// MARK: Get reviews for a rastaurant
extension RestaurantReviewsService {
    func fetchReviews(restaurantId id: String, completion: @escaping (_ status: Bool, _ message: String, _ reviews: [Review]?) -> ()) {
        let collection = Firestore.firestore().collection("restaurants").document(id).collection("reviews")
        
        collection.getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(false, error.localizedDescription, nil)
            } else {
                guard let documents = querySnapshot?.documents else {
                    completion(false, "Error", nil)
                    return
                }
                
                
            }
        }
    }
}

// MARK: Add a review to a rastaurant
extension RestaurantReviewsService {
    func addReview(restaurantId id: String, review: Review, completion: @escaping (_ status: Bool, _ message: String) -> ()) {
        let collection = Firestore.firestore().collection("restaurants").document(id).collection("reviews")
        
        do {
            let _ = try collection.addDocument(from: review)
            completion(true, "Success")
        } catch {
            debugPrint(error)
            completion(false, error.localizedDescription)
        }
    }
}

// MARK: Update rating
extension RestaurantReviewsService {
    func updateRating(restaurantId id: String, rating: Double, completion: @escaping (_ status: Bool, _ message: String) -> ()) {
        let document = Firestore.firestore().collection("restaurants").document(id)
        
        
    }
}
