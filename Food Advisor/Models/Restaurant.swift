//
//  Restaurant.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2020-12-25.
//

import Foundation

struct Restaurant: Identifiable, Codable {
    var id: String?
    var name: String
    var plusCode: String?
    var reviews: [Review]?
    var isSponsored: Bool
}

struct Review: Codable {
    var comment: String
    var rating: Int
    var userId: String
}
