//
//  Restaurant.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2020-12-25.
//

import Foundation
import FirebaseFirestoreSwift

struct Restaurant: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var plusCode: String?
    var isSponsored: Bool
    var location: String
    var thumbnail: String?
    var description: String?
    var facebook: String?
    var website: String?
    var instagram: String?
    var phone: String?
    var maps: String?
    var rating: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, name, plusCode, isSponsored, thumbnail, location, description, facebook, website, instagram, phone, maps, rating
    }
    
    var messengerUrl: URL? {
        guard let pageId = facebook else { return nil }
        
        let webUrl = "http://m.me/\(pageId)"
        
        return URL(string: webUrl)
    }
    
    var facebookUrl: URL? {
        guard let pageId = facebook else { return nil }
        
        let webUrl = "https://www.facebook.com/\(pageId)/"
        
        return URL(string: webUrl)
    }
}

extension Restaurant: Hashable {
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
