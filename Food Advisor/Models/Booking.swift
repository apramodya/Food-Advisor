//
//  Booking.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2021-01-05.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Booking: Identifiable, Codable {
    @DocumentID var id: String?
    var bookingDateTime: Timestamp?
    var corkage: Bool?
    var duration: Int?
    var headCount: Int?
    var restautantID: String?
    var userID: String?
}
