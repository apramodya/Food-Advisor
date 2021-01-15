//
//  LottieCell.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2021-01-06.
//

import UIKit
import Lottie

class LottieCell: UITableViewCell {
    
    // MARK: Variables
    static let id = "LottieCell"
    static let nib = UINib(nibName: id, bundle: nil)
    
    @IBOutlet weak var animationView: AnimationView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell() {
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
    }
}
