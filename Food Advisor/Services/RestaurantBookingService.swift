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
        
       
    }
}

// MARK: Update a booking
extension RestaurantBookingService {
    func updateBooking(docID: String,
                       bookingDateTime: Timestamp,
                       corkage: Bool,
                       duration: Int,
                       headCount: Int,
                       restautantID: String,
                       userID: String,
                       completion: @escaping (_ status: Bool, _ message: String) -> ()) {
        let document = Firestore.firestore().collection("bookings").document(docID)
        
        document.setData(
            [
                "bookingDateTime": bookingDateTime,
                "corkage": corkage,
                "duration": duration,
                "headCount": headCount,
                "restautantID": restautantID,
                "userID": userID,]) { (error) in
            if let error = error {
                debugPrint(error)
                completion(false, error.localizedDescription)
            }
            
            completion(true, "Booking updated successfully.")
        }
    }
}

// MARK: Fetch bookings
extension RestaurantBookingService {
    func fetchBookings(userID: String, completion: @escaping (_ status: Bool, _ message: String, _ booking: [Booking]?) -> ()) {
        let collection = Firestore.firestore().collection("bookings")
            .whereField("userID", isEqualTo: userID)
            .order(by: "bookingDateTime", descending: true)
        
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
