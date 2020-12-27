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
    
    // MARK: Typealias
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Restaurant>
    private typealias SnapShot = NSDiffableDataSourceSnapshot<Section, Restaurant>
    
    // MARK: IBOutlets
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Variables
    var normalRestaurants = [Restaurant]()
    var sponsoredRestaurants = [Restaurant]()
    private var dataSource: DataSource! = nil
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        configureDataSource()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchRestaurants()
    }
}

extension RestaurantsVC: UICollectionViewDelegate {
    private enum Section: String, CaseIterable {
        case Sponsored
        case Other
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.register(RestaurantCollectionViewCell.nib,
                                forCellWithReuseIdentifier: RestaurantCollectionViewCell.id)
        collectionView.register(SponsoredRestaurantCollectionViewCell.nib,
                                forCellWithReuseIdentifier: SponsoredRestaurantCollectionViewCell.id)
        collectionView.collectionViewLayout = generateLayout()
    }
    
    private func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
                                                            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let sectionLayoutKind = Section.allCases[sectionIndex]
            switch sectionLayoutKind {
            case .Sponsored: return self.generateSponsoredLayout()
            case .Other: return self.generateOthersLayout()
            }
        }
        return layout
    }
    
    private func generateSponsoredLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 10, trailing: 5)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6), heightDimension: .estimated(250))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPaging
        return layoutSection
    }
    
    private func generateOthersLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 10, trailing: 5)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .estimated(200))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPaging
        return layoutSection
    }
    
    private func configureDataSource() {
        dataSource = DataSource(collectionView: collectionView,
                                cellProvider: { (cv, indexPath, routine) -> UICollectionViewCell? in
                                    let sectionType = Section.allCases[indexPath.section]
                                    switch sectionType {
                                    case .Sponsored:
                                        guard let cell = cv
                                                .dequeueReusableCell(withReuseIdentifier: SponsoredRestaurantCollectionViewCell.id,
                                                                     for: indexPath) as? SponsoredRestaurantCollectionViewCell
                                        else { fatalError("SponsoredRestaurantCollectionViewCell")}
                                        cell.setupCell(with: self.sponsoredRestaurants[indexPath.row])
                                        
                                        return cell
                                    case.Other:
                                        guard let cell = cv
                                                .dequeueReusableCell(withReuseIdentifier: RestaurantCollectionViewCell.id,
                                                                     for: indexPath) as? RestaurantCollectionViewCell
                                        else { fatalError("RestaurantCollectionViewCell")}
                                        cell.setupCell(with: self.normalRestaurants[indexPath.row])
                                        
                                        return cell
                                    }
                                })
        
        let snapshot = snapshotForCurrentState()
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func snapshotForCurrentState() -> SnapShot {
        var snapshot = SnapShot()
        
        snapshot.appendSections([Section.Sponsored])
        snapshot.appendItems(sponsoredRestaurants)
        
        snapshot.appendSections([Section.Other])
        snapshot.appendItems(normalRestaurants)
        
        return snapshot
    }
}

// MARK: Network requests
extension RestaurantsVC {
    private func fetchRestaurants() {
        RestaurantService.shared.fetchRestaurants { (success, message, restaurants) in
            if success {
                if let restaurants = restaurants {
                    self.normalRestaurants = restaurants
                    self.sponsoredRestaurants = restaurants.filter{ $0.isSponsored == true }
                    
                    DispatchQueue.main.async {
                        self.configureDataSource()
                    }
                }
            } else {
                print(message)
            }
        }
    }
}
