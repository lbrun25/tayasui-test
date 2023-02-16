//
//  RecipePreviewController.swift
//  tayasui-test
//
//  Created by Lucien Brun on 16/02/2023.
//

import Foundation

class RecipePreviewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var ingredientsTitle: UILabel!
    @IBOutlet weak var ingredients: UILabel!
    
    var recipe: Recipe!
    
    override func viewDidLoad() {
        titleLabel.text = recipe.name
        
        imageView.image = recipe.image
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        
        ingredientsTitle.text = "Ingrédients"
        ingredients.text = recipe.ingredients
        ingredients.numberOfLines = 2
    }
}
