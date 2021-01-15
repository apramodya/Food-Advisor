//
//  ForumVC.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2020-12-21.
//

import UIKit
import Lottie

class ForumVC: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var reviewsView: UIView!
    @IBOutlet weak var forumView: UIView!
    @IBOutlet weak var animationView: AnimationView!
    
    // MARK: Variables
    static let id = "ForumVC"
    
    // MARK: Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        animate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // MARK: IBActions
    @IBAction func didTapOnReviews(_ sender: Any) {
        AppNavigator.shared.pushToViewController(in: .Forum, for: ReviewsVC.id, from: self)
    }
    
    @IBAction func didTapOnForum(_ sender: Any) {
        AppNavigator.shared.pushToViewController(in: .Forum, for: AllForumsVC.id, from: self)
    }
}

// MARK: Private methods
extension ForumVC {
    private func animate() {
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
    }
    
    private func setupUI() {
        reviewsView.layer.cornerRadius = 15
        forumView.layer.cornerRadius = 15
    }
}
