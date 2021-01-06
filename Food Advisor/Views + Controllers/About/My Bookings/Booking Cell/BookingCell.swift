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
    var didTapOnView: (() -> ())?
    var didTapOnEdit: (() -> ())?
    
    // MARK: IBOutlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var viewButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    // MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction private func didTapOnViewButton(_ sender: Any) {
        didTapOnView?()
    }
    
    @IBAction private func didTapOnEditButton(_ sender: Any) {
        didTapOnEdit?()
    }
}

// MARK: Methods
extension BookingCell {
    func setupCell(with booking: Booking, isEditable: Bool = true) {
        timeLabel.text = booking.bookingTime
        dateLabel.text = booking.bookingDate
        
        containerView.layer.cornerRadius = 10
        
        editButton.isHidden = !isEditable
    }
}
