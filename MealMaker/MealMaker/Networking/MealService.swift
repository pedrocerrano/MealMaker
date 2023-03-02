//
//  MealService.swift
//  MealMaker
//
//  Created by iMac Pro on 3/1/23.
//

import UIKit

struct MealService {
    
    static func fetchAllCategories(completion: @escaping (Result<[Category], NetworkError>) -> Void) {
        guard let finalURL = URL(string: Constants.MealService.allCategoriesBaseURL) else { completion(.failure(.invalidURL)) ; return }
        print("fetchAllCategories Final URL: \(finalURL)")
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error {
                completion(.failure(.thrownError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("fetchAllCategoeies Response Status Code: \(response.statusCode)")
            }
            
            guard let data = data else { completion(.failure(.noData)) ; return }
            do {
                let topLevel = try JSONDecoder().decode(CategoryTopLevelDictionary.self, from: data)
                completion(.success(topLevel.categories))
            } catch {
                completion(.failure(.unableToDecode))
            }
        }.resume()
    }
    
    
    static func fetchMealsInCategory(forCategory category: Category, completion: @escaping (Result<[Meal], NetworkError>) -> Void) {
        guard let baseURL         = URL(string: Constants.MealService.mealsInCategoryBaseURL) else { completion(.failure(.invalidURL)) ; return }
        var urlComponents         = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let categoryQueryItem     = URLQueryItem(name: Constants.MealService.categoryQueryKey, value: category.categoryName)
        urlComponents?.queryItems = [categoryQueryItem]
        
        guard let finalURL = urlComponents?.url else { completion(.failure(.invalidURL)) ; return }
        print("fetchMeals Final URL: \(finalURL)")
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error {
                completion(.failure(.thrownError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("fetchMeals Response Status Code: \(response.statusCode)")
            }
            
            guard let data = data else { completion(.failure(.noData)) ; return }
            do {
                let topLevel = try JSONDecoder().decode(MealTopLevelDictionary.self, from: data)
                completion(.success(topLevel.meals))
            } catch {
                completion(.failure(.unableToDecode))
            }
        }.resume()
    }
    
    
    static func fetchRecipe(forMeal meal: Meal, completion: @escaping (Result<Recipe, NetworkError>) -> Void) {
        guard let baseURL = URL(string: Constants.MealService.fetchRecipeBaseURL) else { completion(.failure(.invalidURL)) ; return }
        var urlComponents           = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let recipeQueryItem         = URLQueryItem(name: Constants.MealService.recipeQueryKey, value: meal.mealID)
        urlComponents?.queryItems   = [recipeQueryItem]
        
        guard let finalURL = urlComponents?.url else { completion(.failure(.invalidURL)) ; return }
        print("fetchRecipe Final URL: \(finalURL)")
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error {
                completion(.failure(.thrownError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("fetchRecipe Response Status Code: \(response.statusCode)")
            }
            
            guard let data = data, !data.isEmpty else { completion(.failure(.noData)) ; return }
            do {
                let topLevel = try JSONDecoder().decode(RecipeTopLevelDictionary.self, from: data)
                if let recipe = topLevel.meals.first {
                    completion(.success(recipe))
                } else {
                    completion(.failure(.emptyArray))
                    return
                }
            } catch {
                completion(.failure(.unableToDecode))
            }
        }.resume()
    }
    
    static func fetchImage(for item: String?, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        guard let item = item else { completion(.success(UIImage(named: "Avengers")!)) ; return }
        
        guard let finalURL = URL(string: item) else { completion(.failure(.invalidURL)) ; return }
        print("fetchImage Final URL: \(finalURL)")
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error {
                completion(.failure(.thrownError(error)))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode) else {
                completion(.failure(.unsuccessfulStatusCode))
                return
            }
            
            guard let data  = data, !data.isEmpty else { completion(.failure(.noData)) ; return }
            guard let image = UIImage(data: data) else { completion(.failure(.unableToDecode)) ; return }
            completion(.success(image))
        }.resume()
    }
}
