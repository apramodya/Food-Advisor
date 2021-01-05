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
    @IBOutlet weak var bookButton: UIButton!
    
    // MARK: Variables
    static let id = "RestaurantVC"
    var restaurantId: String?
    var restaurant: Restaurant?
    var meals = [Meal]()
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setupCollectionView()
        fetchRestaurant()
        fetchMeals()
    }
    
    // MARK: IBActions
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
    
    @IBAction func didTapOnBookButton(_ sender: Any) {
        gotoMakeABooking()
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
    
    private func fetchMeals() {
        guard let id = restaurantId else { return }
        
        SwiftSpinner.show("Hang tight!\n We are fetching meals details")
        RestaurantService.shared.fetchMealsForRestaurant(for: id) { (success, message, meals) in
            SwiftSpinner.hide()
            
            if success, let meals = meals {
                self.meals = meals
                self.collectionView.reloadData()
            } else {
                print(message)
            }
        }
    }
}

// MARK: UICollectionView
extension RestaurantVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        meals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MealCell.id, for: indexPath) as! MealCell
        let meal = meals[indexPath.row]
        cell.setupCell(with: meal)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 150, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let meal = meals[indexPath.row]
        
        let vc = storyboard?.instantiateViewController(identifier: MealVC.id) as! MealVC
        vc.meal = meal
        
        present(vc, animated: true, completion: nil)
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MealCell.nib, forCellWithReuseIdentifier: MealCell.id)
    }
    
    private func configureView() {
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = true
        bookButton.layer.cornerRadius = 8
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
        } else {
            AlertVC.presentAlert(for: self, title: "Sorry", message: "We can't find telephone number this time.", left: "OK") {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    private func openWebsite(for type: WebsiteType) {
        switch type {
        case .Facebook:
            if let website = restaurant?.facebook,
               let url = URL(string: website),
               UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:])
            } else {
                AlertVC.presentAlert(for: self, title: "Sorry", message: "We can't open Facebook page this time.", left: "OK") {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        case .Web:
            if let website = restaurant?.website,
               let url = URL(string: website),
               UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:])
            } else {
                AlertVC.presentAlert(for: self, title: "Sorry", message: "We can't open website this time.", left: "OK") {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        case .Instagram:
            if let website = restaurant?.instagram,
               let url = URL(string: website),
               UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:])
            } else {
                AlertVC.presentAlert(for: self, title: "Sorry", message: "We can't open Instagram page this time.", left: "OK") {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        case .Maps:
            if let website = restaurant?.maps,
               let url = URL(string: website),
               UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:])
            } else {
                AlertVC.presentAlert(for: self, title: "Sorry", message: "We can't open map directions this time.", left: "OK") {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    private func gotoMakeABooking() {
        let vc = storyboard?.instantiateViewController(identifier: BookingVC.id) as! BookingVC
        navigationController?.pushViewController(vc, animated: true)
    }
}
