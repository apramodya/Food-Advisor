//
//  RestaurantCollectionViewCell.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2020-12-25.
//

import UIKit

class RestaurantCollectionViewCell: UICollectionViewCell {

    static let id = "RestaurantCollectionViewCell"
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
        
        
        containerView.layer.cornerRadius = 8
    }

}
