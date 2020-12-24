//
//  ViewController.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2020-12-20.
//

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift

class RestaurantsVC: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Variables
    var restaurants = [Restaurant]()
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchRestaurants()
    }
}

// MARK: Network requests
extension RestaurantsVC {
    private func fetchRestaurants() {
        RestaurantService.shared.fetchRestaurants { (success, message, restaurants) in
            if success {
                self.restaurants = restaurants ?? []
                
                print(self.restaurants)
            } else {
                print(message)
            }
        }
    }
}
