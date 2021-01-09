//
//  MealCell.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2020-12-27.
//

import UIKit
import SDWebImage

class MealCell: UICollectionViewCell {
    
    // MARK: Variables
    static let id = "MealCell"
    static let nib = UINib(nibName: id, bundle: nil)
    
    // MARK: IBOutlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}

// MARK: Methods
extension MealCell {
    func setupCell(with meal: Meal) {
        titleLabel.text = meal.name
        
        if let image = meal.thumbnail {
            thumbnailImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
            thumbnailImage.sd_setImage(with: URL(string: image))
        }
        
        thumbnailImage.layer.cornerRadius = 5
        containerView.layer.cornerRadius = 8
    }
}
