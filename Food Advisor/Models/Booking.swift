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

extension Booking {
    var bookingTime: String {
        guard let _time = bookingDateTime?.dateValue() else { return "N/A" }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        let time = formatter.string(from: _time)
        
        return time
    }
    
    var bookingDate: String {
        guard let _date = bookingDateTime?.dateValue() else { return "N/A" }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MMM d"
        let date = formatter.string(from: _date)
        
        return date
    }
}
