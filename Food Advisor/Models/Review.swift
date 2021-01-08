//
//  Review.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2021-01-08.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Review: Codable {
    var rating: Int = 0
    var comment: String?
    var author: String?
    var avatar: String?
}
