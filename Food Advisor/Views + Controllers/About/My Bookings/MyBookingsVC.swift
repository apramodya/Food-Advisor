//
//  MyBookingsVC.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2021-01-06.
//

import UIKit
import SwiftSpinner

class MyBookingsVC: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Variables
    static let id = "MyBookingsVC"
    let sections = [
        Section(type: .Upcoming),
        Section(type: .Lottie),
        Section(type: .Past),
    ]
    var upcomingBookings = [Booking]()
    var pastBookings = [Booking]()
    
    // MARK: Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureView()
        fetchBookings()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
}

// MARK: Private methods
extension MyBookingsVC {
    private func configureView() {
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = true
    }
}

// MARK: Network requests
extension MyBookingsVC {
    private func fetchBookings() {
        guard let userID = LocalUser.shared.getUserID() else { return }
        
        
    }
}

// MARK: UITableView
extension MyBookingsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section].type
        
        switch section {
        case .Upcoming: return upcomingBookings.count > 0 ? upcomingBookings.count : 1
        case .Past: return pastBookings.count > 0 ? pastBookings.count : 1
        case .Lottie: return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section].type
        
        switch section {
        case .Upcoming:
            if upcomingBookings.count > 0 {
                let booking = upcomingBookings[indexPath.row]
                let cell = tableView
                    .dequeueReusableCell(withIdentifier: BookingCell.id, for: indexPath) as! BookingCell
                cell.setupCell(with: booking)
                
                cell.didTapOnEdit = { [weak self] in
                    
                }
                
                cell.didTapOnView = { [weak self] in
                    
                }
                
                return cell
            } else {
                let cell = tableView
                    .dequeueReusableCell(withIdentifier: NothinToShowCell.id) as! NothinToShowCell
                return cell
            }
        case .Past:
            if pastBookings.count > 0 {
                let booking = pastBookings[indexPath.row]
                let cell = tableView
                    .dequeueReusableCell(withIdentifier: BookingCell.id, for: indexPath) as! BookingCell
                cell.setupCell(with: booking, isEditable: false)
                
                cell.didTapOnView = { [weak self] in
                    let storyboard = UIStoryboard(name: "About", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: ViewBookingVC.id) as! ViewBookingVC
                    vc.booking = booking
                    self?.present(vc, animated: true, completion: nil)
                }
                
                return cell
            } else {
                let cell = tableView
                    .dequeueReusableCell(withIdentifier: NothinToShowCell.id) as! NothinToShowCell
                return cell
            }
        case .Lottie:
            let cell = tableView
                .dequeueReusableCell(withIdentifier: LottieCell.id) as! LottieCell
            cell.setupCell()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = sections[section].type
        
        switch section {
        case .Upcoming: return "Upcoming bookings"
        case .Past: return "Past bookings"
        case .Lottie: return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = sections[indexPath.section].type
        
        switch section {
        case .Past, .Upcoming: return 80
        case .Lottie: return 200
        }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BookingCell.nib, forCellReuseIdentifier: BookingCell.id)
        tableView.register(NothinToShowCell.nib, forCellReuseIdentifier: NothinToShowCell.id)
        tableView.register(LottieCell.nib, forCellReuseIdentifier: LottieCell.id)
        tableView.sectionHeaderHeight = 30
    }
    
    enum SectionType: CaseIterable {
        case Upcoming, Past, Lottie
    }
    
    struct Section {
        var type: SectionType
    }
}
