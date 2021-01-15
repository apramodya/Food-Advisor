//
//  BookingVC.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2021-01-05.
//

import UIKit
import SwiftSpinner
import FirebaseFirestore

class BookingVC: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var bookingDateTextField: UITextField!
    @IBOutlet weak var bookingTimeTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var headCountTextField: UITextField!
    @IBOutlet weak var isHavingLiquorSwitch: UISwitch!
    @IBOutlet weak var submitButton: UIButton!
    
    // MARK: Variables
    static let id = "BookingVC"
    var booking: Booking? {
        didSet {
            restaurantId = booking?.restautantID
        }
    }
    let datepicker = UIDatePicker()
    var restaurantId: String?
    var selectedDate: Date?
    var selectedTime: Date?
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    // MARK: IBActions
    @IBAction func didTapOnSubmitButton(_ sender: Any) {
        submitBooking()
    }
}

// MARK: Network requests
extension BookingVC {
    private func createBooking() {
        SwiftSpinner.show("Hang tight!\n We are submitting your booking details.")
        
        guard let time = selectedTime,
              let date = selectedDate,
              let dateTime = combine(date: date, time: time),
              let userID = LocalUser.shared.getUserID(),
              let restaurantId = restaurantId else {
            SwiftSpinner.hide()
            return
        }
        
        let bookingDateTime = Timestamp(date: dateTime)
        let corkage = isHavingLiquorSwitch.isOn
        let duration = Int(durationTextField.text ?? "1") ?? 1
        let headCount = Int(headCountTextField.text ?? "1") ?? 1
        
        RestaurantBookingService.shared.createBooking(bookingDateTime: bookingDateTime, corkage: corkage, duration: duration, headCount: headCount, restautantID: restaurantId, userID: userID) { (success, message) in
            SwiftSpinner.hide()
            
            if success {
                AlertVC.presentAlert(for: self, title: "Success", message: message, left: "OK") {
                    self.dismiss(animated: true) {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            } else {
                AlertVC.presentAlert(for: self, title: "Error", message: message, left: "OK") {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    private func updateBooking() {
        SwiftSpinner.show("Hang tight!\n We are updating your booking details.")
        
        guard let time = selectedTime,
              let date = selectedDate,
              let dateTime = combine(date: date, time: time),
              let documentID = booking?.id,
              let userID = LocalUser.shared.getUserID(),
              let restaurantId = restaurantId else {
            SwiftSpinner.hide()
            return
        }
        
        let bookingDateTime = Timestamp(date: dateTime)
        let corkage = isHavingLiquorSwitch.isOn
        let duration = Int(durationTextField.text ?? "1") ?? 1
        let headCount = Int(headCountTextField.text ?? "1") ?? 1
        
        RestaurantBookingService.shared.updateBooking(docID: documentID, bookingDateTime: bookingDateTime, corkage: corkage, duration: duration, headCount: headCount, restautantID: restaurantId, userID: userID) { (success, message) in
            SwiftSpinner.hide()
            
            if success {
                AlertVC.presentAlert(for: self, title: "Success", message: message, left: "OK") {
                    self.dismiss(animated: true) {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            } else {
                AlertVC.presentAlert(for: self, title: "Error", message: message, left: "OK") {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    private func fetchRestaurant() {
        guard let id = restaurantId else { return }
        
        RestaurantService.shared.fetchRestaurant(for: id) { (success, message, restaurant) in
            if success {
                if let restaurant = restaurant {
                    self.placeLabel.text = "Booking details of your booking at \(restaurant.name)"
                }
            } else {
                print(message)
            }
        }
    }
}

// MARK: UITextFieldDelegate
extension BookingVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == bookingDateTextField {
            createDatePicker()
        } else if textField == bookingTimeTextField {
            createTimePicker()
        }
    }
}

// MARK: Private methods
extension BookingVC {
    private func configureView() {
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = true
        submitButton.layer.cornerRadius = 8
        bookingDateTextField.delegate = self
        bookingTimeTextField.delegate = self
        
        if let booking = booking {
            title = "Update booking"
            placeLabel.isHidden = false
            
            fetchRestaurant()
            
            durationTextField.text = "\(booking.duration ?? 0)"
            headCountTextField.text = "\(booking.headCount ?? 0)"
            isHavingLiquorSwitch.isOn = booking.corkage ?? false
            
            let dateformator = DateFormatter()
            dateformator.dateStyle = .medium
            dateformator.timeStyle = .none
            bookingDateTextField.text = dateformator.string(from: booking.dateTime)
            selectedDate = booking.dateTime
            
            dateformator.dateStyle = .none
            dateformator.timeStyle = .medium
            bookingTimeTextField.text = dateformator.string(from: booking.dateTime)
            selectedTime = booking.dateTime
            
            submitButton.setTitle("Update", for: .normal)
        }
    }
    
    private func validateFields() -> (Bool, String?) {
        if bookingDateTextField.text!.isEmpty {
            return (false, "Booking date is empty")
        } else if bookingTimeTextField.text!.isEmpty {
            return (false, "Booking time is empty")
        } else if durationTextField.text!.isEmpty {
            return (false, "Duration of stay is empty")
        } else if headCountTextField.text!.isEmpty {
            return (false, "Number of people is empty")
        }
        
        return (true, nil)
    }
    
    private func submitBooking() {
        let isFormValid = validateFields().0
        
        if !isFormValid {
            if let message = validateFields().1 {
                AlertVC.presentAlert(for: self, title: "Error", message: message, left: "OK") {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        } else {
            if let _ = booking {
                updateBooking()
            } else {
                createBooking()
            }
        }
    }
    
    private func combine(date: Date, time: Date) -> Date? {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.day, .month, .year], from: date)
        let timeComponents = calendar.dateComponents([.hour, .minute, .second], from: time)
        
        var newComponents = DateComponents()
        newComponents.timeZone = .current
        newComponents.day = dateComponents.day
        newComponents.month = dateComponents.month
        newComponents.year = dateComponents.year
        newComponents.hour = timeComponents.hour
        newComponents.minute = timeComponents.minute
        newComponents.second = timeComponents.second
        
        return calendar.date(from: newComponents)
    }
    
    private func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let donebtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(datePicked))
        toolbar.setItems([donebtn], animated: true)
        
        bookingDateTextField.inputAccessoryView = toolbar
        bookingDateTextField.inputView = datepicker
        datepicker.datePickerMode = .date
    }
    
    @objc
    private func datePicked() {
        let dateformator = DateFormatter()
        dateformator.dateStyle = .medium
        dateformator.timeStyle = .none
        
        bookingDateTextField.text = dateformator.string(from: datepicker.date)
        selectedDate = datepicker.date
        view.endEditing(true)
    }
    
    private func createTimePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let donebtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(timePicked))
        toolbar.setItems([donebtn], animated: true)
        
        bookingTimeTextField.inputAccessoryView = toolbar
        bookingTimeTextField.inputView = datepicker
        datepicker.datePickerMode = .time
    }
    
    @objc
    private func timePicked() {
        let dateformator = DateFormatter()
        dateformator.dateStyle = .none
        dateformator.timeStyle = .short
        
        bookingTimeTextField.text = dateformator.string(from: datepicker.date)
        selectedTime = datepicker.date
        view.endEditing(true)
    }
}
