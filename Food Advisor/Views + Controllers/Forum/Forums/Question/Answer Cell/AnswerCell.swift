//
//  AnswerCell.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2021-01-12.
//

import UIKit
import SDWebImage

class AnswerCell: UITableViewCell {
    
    // MARK: Variables
    static let id = "AnswerCell"
    static let nib = UINib(nibName: id, bundle: nil)
    
    // MARK: IBOutlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    // MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension AnswerCell {
    func setupCell(with answer: ForumAnswer) {
        if let image = answer.author?.avatar {
            avatarImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
            avatarImage.sd_setImage(with: URL(string: image))
        }
        
        answerLabel.text = answer.answer
        authorLabel.text = "By: \(answer.author?.name ?? "N/A")"
        dateTimeLabel.text = answer.readableDataTime
        avatarImage.layer.cornerRadius = avatarImage.bounds.height / 2
        containerView.layer.cornerRadius = 8
    }
}
