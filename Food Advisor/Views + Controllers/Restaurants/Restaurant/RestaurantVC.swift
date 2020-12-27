//
//  RestaurantVC.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2020-12-27.
//

import UIKit
import SwiftSpinner

class RestaurantVC: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Variables
    static let id = "RestaurantVC"
    var restaurantId: String?
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = true
        fetchRestaurant()
    }
}

// MARK: Network requests
extension RestaurantVC {
    private func fetchRestaurant() {
        guard let id = restaurantId else { return }
        
        SwiftSpinner.show("Hang tight!\n We are fetching restaurant details")
        RestaurantService.shared.fetchRestaurant(for: id) { (success, message, restaurant) in
            SwiftSpinner.hide()
            
            if success {
                print(restaurant)
            } else {
                print(message)
            }
        }
    }
}
