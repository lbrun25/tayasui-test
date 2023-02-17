//
//  RecipeDetailsViewModel.swift
//  tayasui-test
//
//  Created by Lucien Brun on 14/02/2023.
//

import Foundation

class RecipeDetailsViewModel {
    let recipe: Recipe
    
    // MARK: - Initializer
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
    
    // MARK: - Action methods
    
    func sendDeleteNotification() {
        NotificationCenter.default.post(name: .recipeDeleted, object: self, userInfo: ["recipe": recipe])
    }
    
    // MARK: - UI helper methods
    
    func durationFormat(duration: TimeInterval) -> String {
        let hours = Int(duration / 3600)
        let minutes = Int(duration.truncatingRemainder(dividingBy: 3600) / 60)
        
        if hours > 0 {
            return "Durée : \(hours)h\(minutes) minute\(minutes == 1 ? "" : "s")"
        } else {
            return "Durée : \(minutes) minute\(minutes == 1 ? "" : "s")"
        }
    }
    
    // MARK: - UI text
    
    func ingredientsTitle() -> String {
        return "Ingrédients"
    }
    
    func directionsTitle() -> String {
        return "Préparation"
    }
    
    func confirmDeletionTitle() -> String {
        return "Destroy"
    }
    
    func cancelDeletionTitle() -> String {
        return "Cancel"
    }
    
    func alertDeletionTitle() -> String {
        return "Title"
    }
    
    func alertDeletionMessage() -> String {
        return "Message"
    }
    
}
