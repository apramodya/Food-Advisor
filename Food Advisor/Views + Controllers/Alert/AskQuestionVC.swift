//
//  AskQuestionVC.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2021-01-12.
//

import UIKit

class AskQuestionVC: UIViewController {
    
    // MARK: - Variables
    static let id = "AskQuestionVC"
    private var onSubmitButtonClick: ((String, Bool) -> ())?
    
    // MARK: - Outlets
    @IBOutlet var alertView: UIView!
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var annonymousSwitch: UISwitch!
    @IBOutlet weak var submitButton: UIButton!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alertView.layer.cornerRadius = 7
    }
    
    // MARK: IBActions
    @IBAction func didTapOnSubmitButton(_ sender: Any) {
        view.endEditing(true)
        
        let _validateForm = validateForm()
        let valid = _validateForm.0
        let message = _validateForm.1 ?? "Something went wrong"
        
        if valid {
            guard let question = questionTextField.text else { return }
            let isAnon = annonymousSwitch.isOn
            
            onSubmitButtonClick?(question, isAnon)
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
extension AskQuestionVC {
    private func validateForm() -> (Bool, String?) {
        if questionTextField.text == "" {
            return (false, "Question text cannot be empty")
        }
        
        return (true, nil)
    }
    
    static func presentAskQuestionPopup(for vc: UIViewController, onSubmit: ((String, Bool) -> ())? = nil) {
        let storyboard = UIStoryboard(name: "Alert", bundle: nil)
        let alert = storyboard.instantiateViewController(withIdentifier: AskQuestionVC.id) as! AskQuestionVC
        alert.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        alert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        vc.present(alert, animated: true, completion: nil)
        
        alert.onSubmitButtonClick = onSubmit
    }
}
