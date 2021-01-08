//
//  SponsoredRestaurantCollectionViewCell.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2020-12-25.
//

import UIKit
import Cosmos
import SDWebImage

class SponsoredRestaurantCollectionViewCell: UICollectionViewCell {
    
    // MARK: Variables
    static let id = "SponsoredRestaurantCollectionViewCell"
    static let nib = UINib(nibName: id, bundle: nil)
    
    // MARK: IBOutlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var starView: CosmosView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var thumbnailImage: UIImageView!
    
    // MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: Methods
extension SponsoredRestaurantCollectionViewCell {
    func setupCell(with restaurant: Restaurant) {
        titleLabel.text = restaurant.name
        locationLabel.text = restaurant.location
        
        if let rating = restaurant.rating {
            starView.settings.fillMode = .half
            starView.rating = rating
        }
        
        if let image = restaurant.thumbnail {
            thumbnailImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
            thumbnailImage.sd_setImage(with: URL(string: image))
        }
        
        thumbnailImage.layer.cornerRadius = 5
        containerView.layer.cornerRadius = 8
    }
}
