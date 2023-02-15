//
//  Recipe.swift
//  tayasui-test
//
//  Created by Lucien Brun on 14/02/2023.
//

import Foundation
import UIKit

@objc class Recipe: NSObject {
    @objc var name: String
    let image: UIImage?
    let ingredients: String
    @objc var duration: TimeInterval
    let directions: String
    @objc var score: UInt8
    
    init(name: String, image: UIImage?, ingredients: String, duration: TimeInterval, directions: String, score: UInt8) {
        self.name = name
        self.image = image
        self.ingredients = ingredients
        self.duration = duration
        self.directions = directions
        self.score = score
    }
}

#if DEBUG
extension Recipe {
    static func generateRandomRecipes(numRecipes: Int) -> [Recipe] {
        var recipes: [Recipe] = []
        
        for _ in 0..<numRecipes {
            let name = "Recipe " + UUID().uuidString
            let duration = TimeInterval(Int.random(in: 800...36000))
            let score = UInt8(Int.random(in: 1...3))
            
            let recipe = Recipe(name: name, image: nil, ingredients: "", duration: duration, directions: "", score: score)
            recipes.append(recipe)
        }
        
        return recipes
    }
}
#endif
