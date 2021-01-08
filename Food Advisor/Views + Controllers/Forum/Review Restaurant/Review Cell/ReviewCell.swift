//
//  ReviewCell.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2021-01-08.
//

import UIKit
import Cosmos
import SDWebImage

class ReviewCell: UITableViewCell {

    // MARK: Variables
    static let id = "ReviewCell"
    static let nib = UINib(nibName: id, bundle: nil)
    
    // MARK: IBOutlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var starView: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: Methods
extension ReviewCell {
    func setupCell(with review: Review) {
        commentLabel.text = review.comment
        starView.settings.fillMode = .half
        starView.rating = Double(review.rating)
        
        if let image = review.avatar {
            avatarImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
            avatarImage.sd_setImage(with: URL(string: image))
        }
        
        authorLabel.text = review.author ?? "N/A"
        
        avatarImage.layer.cornerRadius = avatarImage.bounds.height / 2
        containerView.layer.cornerRadius = 8
    }
}
