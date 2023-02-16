//
//  NSMutableArray+Recipe.swift
//  tayasui-test
//
//  Created by Lucien Brun on 15/02/2023.
//

import Foundation

extension NSMutableArray {
    func indexOfRecipe(_ recipeToFind: Recipe) -> Int? {
        return (0..<self.count).compactMap { (i) -> Int? in
            if let recipe = self[i] as? Recipe, recipe == recipeToFind {
                return i
            }
            return nil
        }.first
    }
    
    func indexOfRecipe(byName name: String) -> Int? {
        for i in 0..<self.count {
            if let recipe = self[i] as? Recipe, recipe.name == name {
                return i
            }
        }
        return nil
    }
}
