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

extension RecipesViewController: UITableViewDelegate {
    
}

//extension RecipesViewController: UIViewControllerPreviewingDelegate {
//    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
//        guard let indexPath = tableView.indexPathForRow(at: location),
//            let cell = tableView.cellForRow(at: indexPath)
//            else { return nil }
//
//        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "RecipeDetailsViewController") as? RecipeDetailsViewController else { return nil }
//
//        let selectedItem = viewModel.recipes[indexPath.row]
//        detailVC.item = selectedItem
//
//        detailVC.preferredContentSize = CGSize(width: 0.0, height: 300)
//
//        previewingContext.sourceRect = cell.frame
//        return detailVC
//    }
//
//    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
//        navigationController?.pushViewController(viewControllerToCommit, animated: true)
//    }
//
//
//}
