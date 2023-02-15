//
//  RecipesViewModel.swift
//  tayasui-test
//
//  Created by Lucien Brun on 14/02/2023.
//

import Foundation
import UIKit

class RecipesViewModel {
    var recipes: [Recipe] = []
    
    func durationFormat(duration: TimeInterval) -> String {
        let hours = Int(duration / 3600)
        let minutes = Int(duration.truncatingRemainder(dividingBy: 3600) / 60)

        if hours > 0 {
            return "\(hours)h\(minutes) mn"
        } else {
            return "\(minutes) mn"
        }
    }
    
    func insertNewRecipe() {
        let image = Recipe.allImages.randomElement()
        // ten at random between 30 and 200 minutes
        let durations = (1...10).map { _ in
            TimeInterval.random(in: 30 * 60...200 * 60)
        }
        let duration = durations.randomElement() ?? TimeInterval(30 * 60)
        let score = UInt8.random(in: 1..<3)
        let recipe = Recipe(
            name: "Nouvelle recette \(self.recipes.count + 1)",
            image: image ?? UIImage(named: "coco"),
            ingredients: "Lorem ipsum",
            duration: duration,
            directions: "Lorem ipsum",
            score: score
        )
        self.recipes.append(recipe)
    }
    
    func indexOfRecipe(_ recipeToFind: Recipe) -> Int? {
        let legacy = self.recipes.convertToLegacy()
        
        return self.recipes.firstIndex(where: { $0 == recipeToFind })
    }
    
    func sortRecipes() {
        let recipeArray = NSMutableArray(array: self.recipes.convertToLegacy())
        print("recipeArray", recipeArray)
        recipeArray.sortRecipes()
    }
    
    // MARK: - Initializer
    
    init() {
        self.recipes = Recipe.mockedData
    }
}
