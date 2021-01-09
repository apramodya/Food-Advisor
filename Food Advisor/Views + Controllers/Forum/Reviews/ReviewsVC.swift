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
        restaurants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let restaurant = restaurants[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantSquareCell.id, for: indexPath) as! RestaurantSquareCell
        cell.setupCell(with: restaurant)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
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

// MARK: Private methods
extension ReviewsVC {
    private func setupUI() {
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = true
    }
}

// MARK: Network requests
extension ReviewsVC {
    private func fetchRestaurants() {
        
    }
}
