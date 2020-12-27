//
//  SponsoredRestaurantCollectionViewCell.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2020-12-25.
//

import UIKit
import SDWebImage

class SponsoredRestaurantCollectionViewCell: UICollectionViewCell {

    static let id = "SponsoredRestaurantCollectionViewCell"
    static let nib = UINib(nibName: id, bundle: nil)
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var thumbnailImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func setupCell(with restaurant: Restaurant) {
        titleLabel.text = restaurant.name
        locationLabel.text = restaurant.location
        
        if let image = restaurant.thumbnail {
            thumbnailImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
            thumbnailImage.sd_setImage(with: URL(string: image))
        }
        
        thumbnailImage.layer.cornerRadius = 5
        containerView.layer.cornerRadius = 8

    }
    
}
