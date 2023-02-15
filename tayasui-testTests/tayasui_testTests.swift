//
//  tayasui_testTests.swift
//  tayasui-testTests
//
//  Created by Lucien Brun on 14/02/2023.
//

import XCTest
@testable import tayasui_test

final class tayasui_testTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() throws {
        let numRecipes = 1000
        let recipes = NSMutableArray(array: Recipe.generateRandomRecipes(numRecipes: numRecipes))

        self.measure {
            recipes.sortRecipes()
        }
    }
    
    func testSortRecipes() {
        let recipe1 = Recipe(name: "Recipe 1", image: nil, ingredients: "Ingredients 1", duration: 30*60, directions: "Directions 1", score: 1)
        let recipe2 = Recipe(name: "Recipe 2", image: nil, ingredients: "Ingredients 2", duration: 60*60, directions: "Directions 2", score: 3)
        let recipe3 = Recipe(name: "Recipe 3", image: nil, ingredients: "Ingredients 3", duration: 45*60, directions: "Directions 3", score: 2)
        let recipe4 = Recipe(name: "Recipe 4", image: nil, ingredients: "Ingredients 4", duration: 120*60, directions: "Directions 4", score: 3)
        let recipe5 = Recipe(name: "Recipe 5", image: nil, ingredients: "Ingredients 5", duration: 60*60, directions: "Directions 5", score: 3)
        let recipe6 = Recipe(name: "Recipe 06", image: nil, ingredients: "Ingredients 6", duration: 60*60, directions: "Directions 6", score: 3)
        let recipes = NSMutableArray(array: [recipe1, recipe2, recipe3, recipe4, recipe5, recipe6])
        
        recipes.sortRecipes()
        
        XCTAssertEqual(recipes[0] as! Recipe, recipe4)
        XCTAssertEqual(recipes[1] as! Recipe, recipe6)
        XCTAssertEqual(recipes[2] as! Recipe, recipe2)
        XCTAssertEqual(recipes[3] as! Recipe, recipe5)
        XCTAssertEqual(recipes[4] as! Recipe, recipe3)
        XCTAssertEqual(recipes[5] as! Recipe, recipe1)
    }

}
