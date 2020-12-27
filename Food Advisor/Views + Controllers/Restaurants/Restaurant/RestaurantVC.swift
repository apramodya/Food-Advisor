//
//  RestaurantVC.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2020-12-27.
//

import UIKit
import Cosmos
import SDWebImage
import SwiftSpinner

enum WebsiteType {
    case Web, Facebook, Instagram, Maps
}

class RestaurantVC: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var starView: CosmosView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Variables
    static let id = "RestaurantVC"
    var restaurantId: String?
    var restaurant: Restaurant?
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = true
        fetchRestaurant()
    }
    
    @IBAction func didTapOnWebsiteButton(_ sender: Any) {
        openWebsite(for: .Web)
    }
    
    @IBAction func didTapOnFacebookButton(_ sender: Any) {
        openWebsite(for: .Facebook)
    }
    
    @IBAction func didTapOnInstagramButton(_ sender: Any) {
        openWebsite(for: .Instagram)
    }
    
    @IBAction func didTapOnMapsButton(_ sender: Any) {
        openWebsite(for: .Maps)
    }
    
    @IBAction func didTapOnMakeCallButton(_ sender: Any) {
        makeCall()
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
                self.restaurant = restaurant
                
                if let restaurant = restaurant {
                    self.setupUI(for: restaurant)
                }
            } else {
                print(message)
            }
        }
    }
}

// MARK: Private methods
extension RestaurantVC {
    private func setupUI(for restaurant: Restaurant) {
        titleLabel.text = restaurant.name
        locationLabel.text = restaurant.location
        descriptionLabel.text = restaurant.description
        
        if let reviews = restaurant.reviews {
            let total = reviews.reduce(0) { $0 + $1.rating}
            let avgRating = Double(total) / Double(reviews.count)
            starView.settings.fillMode = .half
            starView.rating = avgRating
        }
        
        if let image = restaurant.thumbnail {
            thumbnailImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
            thumbnailImage.sd_setImage(with: URL(string: image))
        }
    }
    
    private func makeCall() {
        if let phone = restaurant?.phone?.trimmingCharacters(in: [" "]),
           let url = URL(string: "tel://\(phone)"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    private func openWebsite(for type: WebsiteType) {
        switch type {
        case .Facebook:
            if let website = restaurant?.facebook,
               let url = URL(string: website),
               UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:])
            }
        case .Web:
            if let website = restaurant?.website,
               let url = URL(string: website),
               UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:])
            }
        case .Instagram:
            if let website = restaurant?.instagram,
               let url = URL(string: website),
               UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:])
            }
        case .Maps:
            if let website = restaurant?.maps,
               let url = URL(string: website),
               UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:])
            }
        }
    }
}
