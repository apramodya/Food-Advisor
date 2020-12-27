//
//  AlertViewController.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2020-12-27.
//

import UIKit

class AlertVC: UIViewController {
    
    // MARK: - Variables
    static let id = "AlertVC"
    private var onLeftButtonClick: (() -> ())?
    private var onRightButtonClick: (() -> ())?
    
    // MARK: - Outlets
    @IBOutlet var alertView: UIView!
    @IBOutlet var alertTitleLabel: UILabel!
    @IBOutlet var alertMessageLabel: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alertView.layer.cornerRadius = 7
    }
    
    // MARK: IBActions
    @IBAction func didTapOnLeftButton(_ sender: UIButton) {
        onLeftButtonClick?()
    }
    
    @IBAction func didTapOnRightButton(_ sender: Any) {
        onRightButtonClick?()
    }
}

// MARK: Methods
extension AlertVC {
    private func config(title: String, message: String, left leftButtonTitle: String, right rightButtonTitle: String? = nil) {
        if let rightButtonTitle = rightButtonTitle {
            rightButton.setTitle(rightButtonTitle, for: .normal)
        } else {
            rightButton.isHidden = true
        }
        
        leftButton.setTitle(leftButtonTitle, for: .normal)
        alertTitleLabel.text = title
        alertMessageLabel.text = message
    }
    
    static func presentAlert(for vc: UIViewController, title: String, message: String, left: String, right: String? = nil, onLeft: (()->())?, onRight: (()->())? = nil) {
        let storyboard = UIStoryboard(name: "Alert", bundle: nil)
        let alert = storyboard.instantiateViewController(withIdentifier: AlertVC.id) as! AlertVC
        alert.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        alert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        vc.present(alert, animated: true, completion: nil)
        
        alert.config(title: title, message: message, left: left, right: right)
        alert.onLeftButtonClick = onLeft
        alert.onRightButtonClick = onRight
    }
}
