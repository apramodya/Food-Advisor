//
//  ForumAnswer.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2021-01-11.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct ForumAnswer: Identifiable, Codable {
    @DocumentID var id: String?
    var author: Author?
    var answer: String?
    var dateTime: Timestamp?
}

extension ForumAnswer {
    var readableDataTime: String {
        guard let _dateTime = dateTime?.dateValue() else { return "N/A" }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MMM d h:mm a"
        let time = formatter.string(from: _dateTime)
        
        return time
    }
}
