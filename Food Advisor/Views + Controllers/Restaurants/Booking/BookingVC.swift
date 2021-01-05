//
//  BookingVC.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2021-01-05.
//

import UIKit

class BookingVC: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var bookingDateTextField: UITextField!
    @IBOutlet weak var bookingTimeTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var headCountTextField: UITextField!
    @IBOutlet weak var isHavingLiquorSwitch: UISwitch!
    @IBOutlet weak var submitButton: UIButton!
    
    // MARK: Variables
    static let id = "BookingVC"
    let datepicker = UIDatePicker()
    
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
        }
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
        view.endEditing(true)
    }
}
