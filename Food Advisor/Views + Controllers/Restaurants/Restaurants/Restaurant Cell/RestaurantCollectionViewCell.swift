//
//  RestaurantCollectionViewCell.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2020-12-25.
//

import UIKit
import SDWebImage
import Cosmos

class RestaurantCollectionViewCell: UICollectionViewCell {
    
    // MARK: Variables
    static let id = "RestaurantCollectionViewCell"
    static let nib = UINib(nibName: id, bundle: nil)
    
    // MARK: IBOutlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var starView: CosmosView!
    @IBOutlet weak var thumbnailImage: UIImageView!
    
    // MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: Methods
extension RestaurantCollectionViewCell {
    func setupCell(with restaurant: Restaurant) {
        titleLabel.text = restaurant.name
        locationLabel.text = restaurant.location
        
        if let reviews = restaurant.reviews {
            let total = reviews.reduce(0) { $0 + $1.rating}
            let avgRating = Double(total) / Double(reviews.count)
            starView.settings.fillMode = .half
            starView.rating = avgRating
        }
        
        if let image = restaurant.thumbnail {
            thumbnailImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
            thumbnailImage.sd_setImage(with: URL(string: image))
        }
        
        thumbnailImage.layer.cornerRadius = 5
        containerView.layer.cornerRadius = 8
    }
}
