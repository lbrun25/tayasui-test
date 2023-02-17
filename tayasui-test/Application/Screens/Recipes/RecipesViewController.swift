//
//  ViewController.swift
//  tayasui-test
//
//  Created by Lucien Brun on 14/02/2023.
//

import UIKit

class RecipesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = RecipesViewModel()
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = viewModel.viewTitle()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: "RecipeTableViewCell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(recipeDeleted), name: .recipeDeleted, object: nil)
        
        viewModel.sortRecipes()
    }
    
    @IBAction func addRecipe(_ sender: Any) {
        viewModel.insertNewRecipe()
        viewModel.sortRecipes()
        let indexPaths = viewModel.addRecipeIndexPaths()
        tableView.insertRows(at: indexPaths, with: .automatic)
        tableView.reloadData()
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
    
    private func deleteRecipeTableViewCell(recipe: Recipe) {
        let indexPaths = viewModel.deleteRecipeIndexPaths(recipe: recipe)
        tableView.beginUpdates()
        tableView.deleteRows(at: indexPaths, with: .automatic)
        tableView.endUpdates()
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
        
        return UIContextMenuConfiguration(identifier: identifier, previewProvider: { [weak self] in
            guard let self = self,
                  let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecipePreviewController") as? RecipePreviewController else {
                return nil
            }
            vc.recipe = recipe
            return vc
        }, actionProvider: { [weak self] suggestedActions in
            guard let self = self else { return nil }
            let share = UIAction(title: self.viewModel.shareTitle(), image: UIImage(systemName: "square.and.arrow.up")) { action in
                // Show system share sheet
            }
            let edit = UIAction(title: self.viewModel.editTitle(), image: UIImage(systemName: "square.and.pencil")) { action in
                // Perform edit
            }
            let delete = UIAction(title: self.viewModel.deleteTitle(), image: UIImage(systemName: "trash"), attributes: .destructive) { [weak self] action in
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
