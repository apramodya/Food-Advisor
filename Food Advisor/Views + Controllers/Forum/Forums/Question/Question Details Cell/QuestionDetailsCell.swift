//
//  QuestionDetailsCell.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2021-01-12.
//

import UIKit
import SDWebImage

class QuestionDetailsCell: UITableViewCell {
    
    // MARK: Variables
    static let id = "QuestionDetailsCell"
    static let nib = UINib(nibName: id, bundle: nil)
    var didUpVote: ((Bool) -> ())?
    
    // MARK: IBOutlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var upVotesCountLabel: UILabel!
    @IBOutlet weak var downVotesCountLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    // MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: IBActions
    @IBAction private func didTapOnUpVoteButton(_ sender: Any) {
        didUpVote?(true)
    }
    
    @IBAction private func didTapOnDownVoteButton(_ sender: Any) {
        didUpVote?(false)
    }
}

extension QuestionDetailsCell {
    func setupCell(with question: ForumQuestion) {
        if let image = question.author?.avatar {
            avatarImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
            avatarImage.sd_setImage(with: URL(string: image))
        }
        
        upVotesCountLabel.text = "\(question.upVotes)"
        downVotesCountLabel.text = "\(question.downVotes)"
        
        questionLabel.text = question.question
        authorLabel.text = "By: \(question.author?.name ?? "N/A")"
        dateTimeLabel.text = question.readableDataTime
        avatarImage.layer.cornerRadius = avatarImage.bounds.height / 2
        containerView.layer.cornerRadius = 8
    }
}
