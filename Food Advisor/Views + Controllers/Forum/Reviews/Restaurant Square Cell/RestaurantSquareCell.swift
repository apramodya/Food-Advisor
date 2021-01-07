//
//  RestaurantSquareCell.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2021-01-07.
//

import UIKit
import Cosmos
import SDWebImage

class RestaurantSquareCell: UICollectionViewCell {

    // MARK: Variables
    static let id = "RestaurantSquareCell"
    static let nib = UINib(nibName: id, bundle: nil)
    
    // MARK: IBOutlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var starView: CosmosView!
    
    // MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}

// MARK: Methods
extension RestaurantSquareCell {
    func setupCell(with restaurant: Restaurant) {
        titleLabel.text = restaurant.name
        
        if let image = restaurant.thumbnail {
            thumbnailImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
            thumbnailImage.sd_setImage(with: URL(string: image))
        }
        
        if let reviews = restaurant.reviews {
            let total = reviews.reduce(0) { $0 + $1.rating}
            let avgRating = Double(total) / Double(reviews.count)
            starView.settings.fillMode = .half
            starView.rating = avgRating
        }
        
        thumbnailImage.layer.cornerRadius = 5
        containerView.layer.cornerRadius = 8
    }
}
