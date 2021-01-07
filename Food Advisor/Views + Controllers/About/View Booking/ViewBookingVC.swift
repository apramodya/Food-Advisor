//
//  ViewBookingVC.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2021-01-06.
//

import UIKit
import SDWebImage

class ViewBookingVC: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var bookingPlaceLabel: UILabel!
    @IBOutlet weak var bookingDateLabel: UILabel!
    @IBOutlet weak var bookingTimeLabel: UILabel!
    @IBOutlet weak var bookingDurationLabel: UILabel!
    @IBOutlet weak var bookingHeadCountLabel: UILabel!
    @IBOutlet weak var viewRestaurantButton: UIButton!
    
    // MARK: Variables
    static let id = "ViewBookingVC"
    var booking: Booking?
    var didTapOnViewRestaurant: ((String) -> ())?
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        fetchRestaurant()
    }
    
    // MARK: IBActions
    @IBAction private func didTapOnViewRestaurantButton(_ sender: Any) {
        guard let id = booking?.restautantID else { return }
        
        dismiss(animated: true) {
            self.didTapOnViewRestaurant?(id)
        }
    }
}

// MARK: Private methods
extension ViewBookingVC {
    private func configureView() {
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = true
        viewRestaurantButton.layer.cornerRadius = 10
        
        if let booking = booking {
            bookingTimeLabel.text = booking.bookingTime
            bookingDateLabel.text = booking.bookingDate
            bookingDurationLabel.text = "\(booking.duration ?? 0)"
            bookingHeadCountLabel.text = "\(booking.headCount ?? 0)"
        }
    }
}

// MARK: Network requests
extension ViewBookingVC {
    private func fetchRestaurant() {
        guard let id = booking?.restautantID else { return }
        
        RestaurantService.shared.fetchRestaurant(for: id) { [self] (success, message, restaurant) in
            if success {
                if let restaurant = restaurant {
                    bookingPlaceLabel.text = restaurant.name
                    
                    if let image = restaurant.thumbnail {
                        restaurantImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
                        restaurantImage.sd_setImage(with: URL(string: image))
                    }
                }
            } else {
                print(message)
            }
        }
    }
}
