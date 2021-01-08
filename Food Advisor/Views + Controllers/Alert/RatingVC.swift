//
//  RatingVC.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2021-01-09.
//

import UIKit
import Cosmos

class RatingVC: UIViewController {
    
    // MARK: - Variables
    static let id = "RatingVC"
    private var onSubmitButtonClick: ((Int, String) -> ())?
    private var ratingValue: Double?
    
    // MARK: - Outlets
    @IBOutlet var alertView: UIView!
    @IBOutlet weak var reviewTextField: UITextField!
    @IBOutlet weak var starView: CosmosView!
    @IBOutlet weak var submitButton: UIButton!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alertView.layer.cornerRadius = 7
        starView.settings.fillMode = .full
        
        starView.didFinishTouchingCosmos = { value in
            self.ratingValue = value
        }
    }
    
    // MARK: IBActions
    @IBAction func didTapOnSubmitButton(_ sender: UIButton) {
        view.endEditing(true)
        
        let _validateForm = validateForm()
        let valid = _validateForm.0
        let message = _validateForm.1 ?? "Something went wrong"
        
        if valid {
            guard let comment = reviewTextField.text, let _rating = ratingValue else { return }
            let rating = Int(_rating)
            
            onSubmitButtonClick?(rating, comment)
        } else {
            AlertVC.presentAlert(for: self, title: "Error", message: message, left: "OK") {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func didTapOnCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: Methods
extension RatingVC {
    private func validateForm() -> (Bool, String?) {
        if reviewTextField.text == "" {
            return (false, "Review text cannot be empty")
        }
        
        if ratingValue == nil {
            return (false, "Rating cannot be empty")
        }
        
        return (true, nil)
    }
    
    static func presentReviewPopup(for vc: UIViewController, onSubmit: ((Int, String) -> ())? = nil) {
        let storyboard = UIStoryboard(name: "Alert", bundle: nil)
        let alert = storyboard.instantiateViewController(withIdentifier: RatingVC.id) as! RatingVC
        alert.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        alert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        vc.present(alert, animated: true, completion: nil)
        
        alert.onSubmitButtonClick = onSubmit
    }
}
