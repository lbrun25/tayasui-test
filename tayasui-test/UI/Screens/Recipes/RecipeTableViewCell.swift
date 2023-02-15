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
                 imageView.tintColor = .gray
                 if index >= score {
                     imageView.isOpaque = false
                     imageView.layer.opacity = 0
                 }
             }
         }
    }

}
