//
//  ViewBookingVC.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2021-01-06.
//

import UIKit
import SwiftSpinner

class ViewBookingVC: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var bookingPlaceLabel: UILabel!
    @IBOutlet weak var bookingDateLabel: UILabel!
    @IBOutlet weak var bookingTimeLabel: UILabel!
    @IBOutlet weak var bookingDurationLabel: UILabel!
    @IBOutlet weak var bookingHeadCountLabel: UILabel!
    
    // MARK: Variables
    static let id = "ViewBookingVC"
    var booking: Booking?
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        fetchRestaurant()
    }
}

// MARK: Private methods
extension ViewBookingVC {
    private func configureView() {
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = true
        
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
        
        SwiftSpinner.show("Hang tight!\n We are fetching booking detail")
        
        RestaurantService.shared.fetchRestaurant(for: id) { (success, message, restaurant) in
            SwiftSpinner.hide()
            
            if success {
                if let restaurant = restaurant {
                    self.bookingPlaceLabel.text = restaurant.name
                }
            } else {
                print(message)
            }
        }
    }
}
