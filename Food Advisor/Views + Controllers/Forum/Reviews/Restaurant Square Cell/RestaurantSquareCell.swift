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
    var restaurantId: String?
    
    // MARK: IBOutlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var starView: CosmosView!
    
    // MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        starView.rating = 0
    }
}

// MARK: Methods
extension RestaurantSquareCell {
    func setupCell(with restaurant: Restaurant) {
        self.restaurantId = restaurant.id
        titleLabel.text = restaurant.name
        
        if let image = restaurant.thumbnail {
            thumbnailImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
            thumbnailImage.sd_setImage(with: URL(string: image))
        }

        if let rating = restaurant.rating {
            starView.settings.fillMode = .half
            starView.rating = rating
        }
        
        thumbnailImage.layer.cornerRadius = 5
        containerView.layer.cornerRadius = 8
    }
}
