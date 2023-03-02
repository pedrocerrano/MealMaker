//
//  Constants.swift
//  MealMaker
//
//  Created by iMac Pro on 3/1/23.
//

import Foundation

struct Constants {
    
    struct MealService {
        static let allCategoriesBaseURL     = "https://www.themealdb.com/api/json/v1/1/categories.php"
        
        static let mealsInCategoryBaseURL   = "https://www.themealdb.com/api/json/v1/1/filter.php"
        static let categoryQueryKey         = "c"
        
        static let fetchRecipeBaseURL       = "https://www.themealdb.com/api/json/v1/1/lookup.php"
        static let recipeQueryKey           = "i"
    }
    
    struct Error {
        static let unknownError = "Unknown error. Good luck figuring this out."
    }
}

