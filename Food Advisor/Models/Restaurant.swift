//
//  Restaurant.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2020-12-25.
//

import Foundation

struct Restaurant: Identifiable, Codable, Hashable {
    var id = UUID()
    var name: String
    var plusCode: String?
    var reviews: [Review]?
    var isSponsored: Bool
    var location: String
    var thumbnail: String?
    
    enum CodingKeys: String, CodingKey {
        case name, plusCode, reviews, isSponsored, thumbnail, location
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

extension Restaurant: Equatable {
    static func == (lhs: Restaurant, rhs: Restaurant) -> Bool {
        if lhs.id == rhs.id {
            return true
        } else {
            return false
        }
    }
}

struct Review: Codable {
    var comment: String
    var rating: Int
    var userId: String
}
