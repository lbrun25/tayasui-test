//
//  RecipeDetailViewController.swift
//  tayasui-test
//
//  Created by Lucien Brun on 14/02/2023.
//

import UIKit

class RecipeDetailsViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var ingredientsTitleLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var directionsTitleLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var directionsLabel: UILabel!
    
    var viewModel: RecipeDetailsViewModel?
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let viewModel = viewModel {
            let item = viewModel.recipe
            title = item.name
            imageView.image = item.image
            ingredientsTitleLabel.text = viewModel.ingredientsTitle()
            ingredientsLabel.text = item.ingredients
            directionsTitleLabel.text = viewModel.directionsTitle()
            durationLabel.text = viewModel.durationFormat(duration: item.duration)
            directionsLabel.text = item.directions
        }
        
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
    }
    
    /// Shows an alert controller to confirm the deletion of a recipe.
    private func confirmDelete() {
        let alertController = UIAlertController(title: viewModel?.alertDeletionTitle(), message: viewModel?.alertDeletionMessage(), preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: viewModel?.confirmDeletionTitle(), style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            self.viewModel?.sendDeleteNotification()
            self.navigationController?.popViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: viewModel?.cancelDeletionTitle(), style: .cancel)
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        alertController.preferredAction = confirmAction
        
        present(alertController, animated: true)
    }
    
    // MARK: - Action methods
    
    @IBAction func delete() {
        confirmDelete()
    }
    
}
