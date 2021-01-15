//
//  ForumItem.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2021-01-11.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct ForumQuestion: Identifiable, Codable {
    @DocumentID var id: String?
    var author: Author?
    var question: String?
    var votes: [Vote]?
    var dateTime: Timestamp?
}

extension ForumQuestion {
    var upVotes: Int {
        guard let votes = votes else { return 0 }
        
        let upVotes = votes.filter({$0.isUpVote}).count
        
        return upVotes
    }
    
    var downVotes: Int {
        guard let votes = votes else { return 0 }
        
        let downVotes = votes.filter({!$0.isUpVote}).count
        
        return downVotes
    }
    
    var readableDataTime: String {
        guard let _dateTime = dateTime?.dateValue() else { return "N/A" }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MMM d h:mm a"
        let time = formatter.string(from: _dateTime)
        
        return time
    }
}

struct Author: Codable {
    var avatar: String?
    var name: String?
    var userID: String?
}

struct Vote: Codable {
    var isUpVote: Bool
    var userID: String?
}
