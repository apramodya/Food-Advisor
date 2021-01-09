//
//  MealVC.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2020-12-27.
//

import UIKit
import SDWebImage

class MealVC: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var itemsListLabel: UILabel!
    
    // MARK: Variables
    static let id = "MealVC"
    var meal: Meal?
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let meal = meal {
            setupMealUI(for: meal)
        }
    }
}

// MARK: Private methods
extension MealVC {
    private func setupMealUI(for meal: Meal) {
        titleLabel.text = meal.name
        descriptionLabel.text = meal.description
        
    }
}
