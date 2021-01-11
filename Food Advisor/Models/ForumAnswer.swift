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
}
