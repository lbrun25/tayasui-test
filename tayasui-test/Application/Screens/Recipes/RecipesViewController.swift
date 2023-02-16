//
//  ViewController.swift
//  tayasui-test
//
//  Created by Lucien Brun on 14/02/2023.
//

import UIKit

class RecipesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = RecipesViewModel()
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Recettes"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: "RecipeTableViewCell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(recipeDeleted), name: .recipeDeleted, object: nil)
        
        viewModel.sortRecipes()
    }
    
    @IBAction func addRecipe(_ sender: Any) {
        viewModel.insertNewRecipe()
        viewModel.sortRecipes()
        if let recipe = viewModel.recipes.lastObject as? Recipe,
           let index = viewModel.recipes.indexOfRecipe(recipe) {
            let indexPath = IndexPath(row: index, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
    }
    
    // MARK: - Segue preparation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecipeDetailsSegue",
           let vc = segue.destination as? RecipeDetailsViewController,
           let selectedIndex = tableView.indexPathForSelectedRow,
           let selectedItem = viewModel.recipes[selectedIndex.row] as? Recipe {
            vc.viewModel = RecipeDetailsViewModel(recipe: selectedItem)
        }
    }
    
    // MARK: - Notification center observers
    
    @objc
    func recipeDeleted(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let recipe = userInfo["recipe"] as? Recipe
        else { preconditionFailure("Expected a Recipe") }
        
        deleteRecipeTableViewCell(recipe: recipe)
    }
    
    func deleteRecipeTableViewCell(recipe: Recipe) {
        if let index = viewModel.recipes.indexOfRecipe(recipe) {
            viewModel.recipes.removeObject(at: index)
            tableView.beginUpdates()
            tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
            tableView.endUpdates()
        }
    }
    
}

// MARK: - Table view data source

extension RecipesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeTableViewCell,
           let recipe = viewModel.recipes[indexPath.row] as? Recipe {
            cell.nameLabel.text = recipe.name
            cell.durationLabel.text = viewModel.durationFormat(duration: recipe.duration)
            cell.setStarStackView(score: recipe.score)
            
            return cell
        }
        
        return UITableViewCell()
    }
}

// MARK: - Table view delegate

extension RecipesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        guard let recipe = viewModel.recipes[indexPath.row] as? Recipe else { return nil }
        let identifier = NSString(string: recipe.name)
        
        return UIContextMenuConfiguration(identifier: identifier, previewProvider: {
            return PreviewRecipeViewController(recipe: recipe)
        }, actionProvider: { suggestedActions in
            let share = UIAction(title: "Partager", image: UIImage(systemName: "square.and.arrow.up")) { action in
                // Show system share sheet
            }
            let edit = UIAction(title: "Éditer", image: UIImage(systemName: "square.and.pencil")) { action in
                // Perform edit
            }
            let delete = UIAction(title: "Supprimer", image: UIImage(systemName: "trash"), attributes: .destructive) { [weak self] action in
                guard let self = self else { return }
                self.deleteRecipeTableViewCell(recipe: recipe)
            }
            return UIMenu(title: "", children: [share, edit, delete])
        })
    }
    
    func tableView(_ tableView: UITableView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
        animator.addCompletion {
            if (animator.previewViewController) != nil {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                guard let vc = storyboard.instantiateViewController(withIdentifier: "RecipeDetailsViewController") as? RecipeDetailsViewController,
                      let identifier = configuration.identifier as? String,
                      let recipeIndex = self.viewModel.recipes.indexOfRecipe(byName: identifier),
                      let recipe = self.viewModel.recipes[recipeIndex] as? Recipe
                else { return }
                vc.viewModel = RecipeDetailsViewModel(recipe: recipe)
                self.show(vc, sender: self)
            }
        }
    }
}