//
//  Constants.swift
//  MealMaker
//
//  Created by iMac Pro on 3/1/23.
//

import Foundation

struct Constants {
    
    struct MealService {
        static let allCategoriesBaseURL   = "www.themealdb.com/api/json/v1/1/categories.php"
        
        static let mealsInCategoryBaseURL = "www.themealdb.com/api/json/v1/1/filter.php"
        static let categoryQueryKey       = "c"
    }
}
