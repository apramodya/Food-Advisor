//
//  BookingCell.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2021-01-06.
//

import UIKit

class BookingCell: UITableViewCell {

    // MARK: Variables
    static let id = "BookingCell"
    static let nib = UINib(nibName: id, bundle: nil)
    
    // MARK: IBOutlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    // MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: Methods
extension BookingCell {
    func setupCell(with booking: Booking) {
        timeLabel.text = booking.bookingTime
        dateLabel.text = booking.bookingDate
        
        containerView.layer.cornerRadius = 10
    }
}
