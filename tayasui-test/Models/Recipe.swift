//
//  Recipe.swift
//  tayasui-test
//
//  Created by Lucien Brun on 14/02/2023.
//

import Foundation
import UIKit

struct Recipe {
    let name: String
    let image: UIImage?
    let ingredients: String
    let duration: TimeInterval
    let directions: String
    let score: UInt8
}

extension Recipe: Equatable {
    static func ==(lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.name == rhs.name &&
            lhs.image == rhs.image &&
            lhs.ingredients == rhs.ingredients &&
            lhs.duration == rhs.duration &&
            lhs.directions == rhs.directions &&
            lhs.score == rhs.score
    }
}

@objc class RecipeLegacy: NSObject {
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

extension Array where Element == Recipe {
    func convertToLegacy() -> [RecipeLegacy] {
        var legacyRecipes: [RecipeLegacy] = []
        for recipe in self {
            let legacyRecipe = RecipeLegacy(
                name: recipe.name, image: recipe.image,
                ingredients: recipe.ingredients, duration: recipe.duration,
                directions: recipe.directions, score: recipe.score
            )
            legacyRecipes.append(legacyRecipe)
        }
        return legacyRecipes
    }
}
