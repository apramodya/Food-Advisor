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
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = true
        addReviewButton.layer.cornerRadius = 8
    }
}

// MARK: Network requests
extension ReviewRestaurantVC {
    private func fetchRestaurant() {
        guard let id = restaurantId else { return }
        
        SwiftSpinner.show("Hang tight!\n We are fetching restaurant details")
        RestaurantService.shared.fetchRestaurant(for: id) { (success, message, restaurant) in
            SwiftSpinner.hide()
            
            if success {
                if let restaurant = restaurant {
                    self.setupUI(for: restaurant)
                }
            } else {
                print(message)
            }
        }
    }
    
    private func fetchReviews() {
        guard let id = restaurantId else { return }
        
        RestaurantReviewsService.shared.fetchReviews(restaurantId: id) { (success, message, reviews) in
            if success, let reviews = reviews {
                self.reviews = reviews
                
                if let userId = LocalUser.shared.getUserID(),
                   reviews.contains(where: {$0.userUID == userId}) {
                    self.addReviewButton.isHidden = true
                }
                
                self.tableView.reloadData()
            } else {
                print(message)
            }
        }
    }
    
    private func addReview(rating: Int, comment: String) {
        guard let id = restaurantId,
              let name = LocalUser.shared.getFirstName(),
              let avatar = LocalUser.shared.getUserAvatarURL(),
              let userId = LocalUser.shared.getUserID()
        else { return }
        
        let review = Review(rating: rating, comment: comment, author: name, avatar: avatar, userUID: userId)
        
        SwiftSpinner.show("Hang tight!\n We are submitting your review.")
        
        RestaurantReviewsService.shared.addReview(restaurantId: id, review: review) { (success, message) in
            SwiftSpinner.hide()
            
            if success {
                self.calculateAndUpdateRatings()
                self.fetchReviews()
            } else {
                AlertVC.presentAlert(for: self, title: "Error", message: message, left: "OK") {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
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
