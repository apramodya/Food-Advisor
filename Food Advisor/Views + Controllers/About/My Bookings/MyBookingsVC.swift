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
    var bookings = [Booking]()
    
    // MARK: Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        fetchBookings()
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
        
        SwiftSpinner.show("Hang tight!\n We are fetching your bookings")
        RestaurantBookingService.shared.fetchBookings(userID: userID) { (success, message, bookings) in
            SwiftSpinner.hide()
            
            if success, let bookings = bookings {
                self.bookings = bookings
                self.tableView.reloadData()
            } else {
                print(message)
            }
        }
    }
}

// MARK: UITableView
extension MyBookingsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bookings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let booking = bookings[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: BookingCell.id, for: indexPath) as! BookingCell
        cell.setupCell(with: booking)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BookingCell.nib, forCellReuseIdentifier: BookingCell.id)
    }
}
