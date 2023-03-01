//
//  Recipe.swift
//  MealMaker
//
//  Created by iMac Pro on 3/1/23.
//

import Foundation

struct RecipeTopLevelDictionary: Decodable {
    let meals: [Recipe]
}

struct Recipe: Decodable {
    private enum CodingKeys: String, CodingKey {
        case mealID = "idMeal"
        case mealName = "strMeal"
        case mealCategory = "strCategory"
        case mealAreaOfOrigin = "strArea"
    }
    
    let mealID: String
    let mealName: String
    let mealCategory: String
    let mealAreaOfOrigin: String
}
