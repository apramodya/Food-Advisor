//
//  Meal.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2020-12-27.
//

import Foundation
import FirebaseFirestoreSwift

struct Meal: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var thumbnail: String?
    var description: String?
    var price: Double?
}
