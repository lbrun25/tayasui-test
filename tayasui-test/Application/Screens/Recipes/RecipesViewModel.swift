//
//  RecipesViewModel.swift
//  tayasui-test
//
//  Created by Lucien Brun on 14/02/2023.
//

import Foundation
import UIKit

class RecipesViewModel {
    var recipes: NSMutableArray = []
    
    // MARK: - Initializer
    
    init() {
        self.recipes = NSMutableArray(array: Recipe.mockedData)
    }
    
    // MARK: - Action methods
    
    func insertNewRecipe() {
        let image = Recipe.allImages.randomElement()
        // ten at random between 30 and 200 minutes
        let durations = (1...10).map { _ in
            TimeInterval.random(in: 30 * 60...200 * 60)
        }
        let duration = durations.randomElement() ?? TimeInterval(30 * 60)
        let score = UInt8.random(in: 1...3)
        let recipe = Recipe(
            name: "Nouvelle recette \(self.recipes.count + 1)",
            image: image ?? UIImage(named: "coco"),
            ingredients: "Lorem ipsum",
            duration: duration,
            directions: "Lorem ipsum",
            score: score
        )
        self.recipes.add(recipe)
    }
    
    func sortRecipes() {
        self.recipes.sortRecipes()
    }
    
    func addRecipeIndexPaths() -> [IndexPath] {
        if let recipe = recipes.lastObject as? Recipe,
           let index = recipes.indexOfRecipe(recipe) {
            let indexPath = IndexPath(row: index, section: 0)
            return [indexPath]
        }
        return []
    }
    
    func deleteRecipeIndexPaths(recipe: Recipe) -> [IndexPath] {
        if let index = recipes.indexOfRecipe(recipe) {
            recipes.removeObject(at: index)
            return [IndexPath(row: index, section: 0)]
        }
        return []
    }
    
    // MARK: - UI text
    
    func viewTitle() -> String {
        return "Recettes"
    }
    
    func shareTitle() -> String {
        return "Partager"
    }
    
    func editTitle() -> String {
        return "Éditer"
    }
    
    func deleteTitle() -> String {
        return "Supprimer"
    }
    
    // MARK: - UI helper methods
    
    func durationFormat(duration: TimeInterval) -> String {
        let hours = Int(duration / 3600)
        let minutes = Int(duration.truncatingRemainder(dividingBy: 3600) / 60)
        
        if hours > 0 {
            return "\(hours)h\(minutes) mn"
        } else {
            return "\(minutes) mn"
        }
    }
}
