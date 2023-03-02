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
        case mealID             = "idMeal"
        case mealName           = "strMeal"
        case mealCategory       = "strCategory"
        case mealAreaOfOrigin   = "strArea"
        case instructions       = "strInstructions"
        case imageURL           = "strMealThumb"
        case youTubeLink        = "strYoutube"
        case ingredients
    }
    
    let mealID: String?
    let mealName: String?
    let mealCategory: String?
    let mealAreaOfOrigin: String?
    let instructions: String?
    let imageURL: String?
    let youTubeLink: String?
    let ingredients: [Ingredient]
    
    var ingredientsAsString: String {
        var result = ""
        ingredients.forEach {
            let ingredientPair = "\($0.name): \($0.measurement)\n"
            result.append(ingredientPair)
        }
        return result
    }
}

struct Ingredient: Decodable {
    let name: String
    let measurement: String
}


//MARK: - EXTENSION
extension Recipe {

    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        
        self.mealID = try? container?.decode(String.self, forKey: .mealID)
        self.mealName = try? container?.decode(String.self, forKey: .mealName)
        self.mealCategory = try? container?.decode(String.self, forKey: .mealCategory)
        self.mealAreaOfOrigin = try? container?.decode(String.self, forKey: .mealAreaOfOrigin)
        self.instructions = try? container?.decode(String.self, forKey: .instructions)
        self.imageURL = try? container?.decode(String.self, forKey: .imageURL)
        self.youTubeLink = try? container?.decode(String.self, forKey: .youTubeLink)
        
        let ingredientNameContainer = try? decoder.container(keyedBy: IngredientCodingKeys.self)
        let measurementNameContainer = try? decoder.container(keyedBy: MeasurementCodingKeys.self)
        
        let ingredients: [Ingredient] = IngredientCodingKeys.allCases.enumerated().compactMap {
            guard let name = try? ingredientNameContainer?.decode(String.self, forKey: $0.element),
                  let measurement = try? measurementNameContainer?.decode(String.self, forKey: MeasurementCodingKeys.allCases[$0.offset]),
                  !name.isEmpty,
                  !measurement.isEmpty
            else { return nil }
            
            return Ingredient(name: name, measurement: measurement)
        }
        
        self.ingredients = ingredients
    }
    
    private enum IngredientCodingKeys: String, CodingKey, CaseIterable {
        case strIngredient1
        case strIngredient2
        case strIngredient3
        case strIngredient4
        case strIngredient5
        case strIngredient6
        case strIngredient7
        case strIngredient8
        case strIngredient9
        case strIngredient10
        case strIngredient11
        case strIngredient12
        case strIngredient13
        case strIngredient14
        case strIngredient15
        case strIngredient16
        case strIngredient17
        case strIngredient18
        case strIngredient19
        case strIngredient20
    }
    
    private enum MeasurementCodingKeys: String, CodingKey, CaseIterable {
        case strMeasure1
        case strMeasure2
        case strMeasure3
        case strMeasure4
        case strMeasure5
        case strMeasure6
        case strMeasure7
        case strMeasure8
        case strMeasure9
        case strMeasure10
        case strMeasure11
        case strMeasure12
        case strMeasure13
        case strMeasure14
        case strMeasure15
        case strMeasure16
        case strMeasure17
        case strMeasure18
        case strMeasure19
        case strMeasure20
    }
}
