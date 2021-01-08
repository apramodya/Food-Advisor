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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    // MARK: IBActions
    @IBAction func didTapOnAddReviewButton(_ sender: Any) {
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
        titleLabel.text = restaurant.name
        
        if let image = restaurant.thumbnail {
            thumbnailImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
            thumbnailImage.sd_setImage(with: URL(string: image))
        }
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
                if let reviews = restaurant?.reviews {
                    self.reviews = reviews
                    self.tableView.reloadData()
                }
                
                if let restaurant = restaurant {
                    self.setupUI(for: restaurant)
                }
            } else {
                print(message)
            }
        }
    }
}
