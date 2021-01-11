//
//  ForumQuestionCell.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2021-01-11.
//

import UIKit
import SDWebImage

class ForumQuestionCell: UITableViewCell {

    // MARK: Variables
    static let id = "ForumQuestionCell"
    static let nib = UINib(nibName: id, bundle: nil)
    
    // MARK: IBOutlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var upVotesCountLabel: UILabel!
    @IBOutlet weak var downVotesCountLabel: UILabel!
    
    // MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension ForumQuestionCell {
    func setupCell(with question: ForumQuestion) {
        if let image = question.author?.avatar {
            avatarImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
            avatarImage.sd_setImage(with: URL(string: image))
        }
        
        upVotesCountLabel.text = "\(question.upVotes)"
        downVotesCountLabel.text = "\(question.downVotes)"
        
        questionLabel.text = question.question
        avatarImage.layer.cornerRadius = avatarImage.bounds.height / 2
        containerView.layer.cornerRadius = 8
    }
}
