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
                
                let reviews = documents.compactMap({ (document) -> Review? in
                    do {
                        return try document.data(as: Review.self)
                    } catch {
                        debugPrint(error)
                        completion(false, error.localizedDescription, nil)
                        return nil
                    }
                })
                
                completion(true, "Success", reviews)
            }
        }
    }
}
