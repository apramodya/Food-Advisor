//
//  ReviewRestaurantVC.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2021-01-08.
//

import UIKit
import SwiftSpinner
import SDWebImage

class ReviewRestaurantVC: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addReviewButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Variables
    static let id = "ReviewRestaurantVC"
    var restaurantId: String?
    var reviews = [Review]()
    
    // MARK: Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupUI()
        fetchRestaurant()
        fetchReviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    // MARK: IBActions
    @IBAction func didTapOnAddReviewButton(_ sender: Any) {
        RatingVC.presentReviewPopup(for: self) { rating, comment in
            self.dismiss(animated: true) {
                self.addReview(rating: rating, comment: comment)
            }
        }
    }
}

// MARK:
extension ReviewRestaurantVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let review = reviews[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: ReviewCell.id, for: indexPath) as! ReviewCell
        cell.setupCell(with: review)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ReviewCell.nib, forCellReuseIdentifier: ReviewCell.id)
    }
}


// MARK: Private methods
extension ReviewRestaurantVC {
    private func setupUI() {
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = true
        addReviewButton.layer.cornerRadius = 8
    }
    
    private func setupUI(for restaurant: Restaurant) {
        
    }
}

// MARK: Network requests
extension ReviewRestaurantVC {
    private func fetchRestaurant() {
        guard let id = restaurantId else { return }
        
        
    }
    
    private func fetchReviews() {
        guard let id = restaurantId else { return }
        
        
    }
    
    private func addReview(rating: Int, comment: String) {
        guard let id = restaurantId,
              let name = LocalUser.shared.getFirstName(),
              let avatar = LocalUser.shared.getUserAvatarURL(),
              let userId = LocalUser.shared.getUserID()
        else { return }
        
        let review = Review(rating: rating, comment: comment, author: name, avatar: avatar, userUID: userId)
        
        
    }
    
    private func calculateAndUpdateRatings() {
        guard let id = restaurantId else { return }
        
        
    }
    
    private func updateRating(rating: Double) {
        guard let id = restaurantId else { return }
        
        RestaurantReviewsService.shared.updateRating(restaurantId: id, rating: rating) { (success, message) in
            if !success {
                print(message)
            }
        }
    }
}
