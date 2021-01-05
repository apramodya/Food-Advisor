//
//  HeaderCollectionReusableView.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2021-01-05.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    
    static let id = "HeaderCollectionReusableView"
    
    @IBOutlet weak var headerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(title: String) {
        headerLabel.text = title
    }
}
