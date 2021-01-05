//
//  RestaurantBookingService.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2021-01-05.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class RestaurantBookingService {
    static let shared = RestaurantBookingService()
}

// MARK: Create a booking
extension RestaurantBookingService {
    func createBooking(bookingDateTime: Timestamp,
                       corkage: Bool,
                       duration: Int,
                       headCount: Int,
                       restautantID: String,
                       userID: String,
                       completion: @escaping (_ status: Bool, _ message: String) -> ()) {
        let collection = Firestore.firestore().collection("bookings")
        
        collection.addDocument(
            data: [
                "bookingDateTime": bookingDateTime,
                "corkage": corkage,
                "duration": duration,
                "headCount": headCount,
                "restautantID": restautantID,
                "userID": userID,
            ]) { (error) in
            if let error = error {
                debugPrint(error)
                completion(false, error.localizedDescription)
            }
        }
        
        completion(true, "Booking placed successfully.")
    }
}
