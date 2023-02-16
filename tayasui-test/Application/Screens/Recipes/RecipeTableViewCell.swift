//
//  RecipeTableViewCell.swift
//  tayasui-test
//
//  Created by Lucien Brun on 14/02/2023.
//

import Foundation
import UIKit

class RecipeTableViewCell: UITableViewCell {
    @IBOutlet weak var starsStackView: UIStackView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    func setStarStackView(score: UInt8) {
        for (index, view) in starsStackView.subviews.enumerated() {
            if let imageView = view as? UIImageView {
                imageView.tintColor = UIColor(red: 0.64, green: 0.64, blue: 0.64, alpha: 1.00)
                if index >= score {
                    imageView.isOpaque = false
                    imageView.layer.opacity = 0
                } else {
                    imageView.isOpaque = true
                    imageView.layer.opacity = 100
                }
            }
        }
    }
    
}
