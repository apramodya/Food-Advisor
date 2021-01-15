//
//  ReviewsVC.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2021-01-07.
//

import UIKit
import SwiftSpinner

class ReviewsVC: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Variables
    static let id = "ReviewsVC"
    var restaurants = [Restaurant]()
    var filteredRestaurants = [Restaurant]()
    
    // MARK: Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupUI()
        fetchRestaurants()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
    }
}

// MARK: UICollectionView
extension ReviewsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filteredRestaurants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let restaurant = filteredRestaurants[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantSquareCell.id, for: indexPath) as! RestaurantSquareCell
        cell.setupCell(with: restaurant)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: ReviewRestaurantVC.id) as! ReviewRestaurantVC
        vc.restaurantId = filteredRestaurants[indexPath.row].id
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 40) / 2
        
        return CGSize(width: width, height: width)
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(RestaurantSquareCell.nib, forCellWithReuseIdentifier: RestaurantSquareCell.id)
    }
}

// MARK: UISearchBar
extension ReviewsVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let key = searchBar.text, key.count > 0 else {
            filteredRestaurants = restaurants
            collectionView.reloadData()
            return
        }
        
        filteredRestaurants = restaurants.filter({$0.name.contains(key)})
        collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        filteredRestaurants = restaurants
        collectionView.reloadData()
    }
}

// MARK: Private methods
extension ReviewsVC {
    private func setupUI() {
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = true
        searchBar.delegate = self
        searchBar.text = ""
    }
}

// MARK: Network requests
extension ReviewsVC {
    private func fetchRestaurants() {
        SwiftSpinner.show("Hang tight!\n We are fetching restaurants")
        RestaurantService.shared.fetchRestaurants { (success, message, restaurants) in
            SwiftSpinner.hide()
            
            if success {
                if let restaurants = restaurants {
                    DispatchQueue.main.async {
                        self.restaurants = restaurants
                        self.filteredRestaurants = restaurants
                        self.collectionView.reloadData()
                    }
                }
            } else {
                print(message)
            }
        }
    }
}
