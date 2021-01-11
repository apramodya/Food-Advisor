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
