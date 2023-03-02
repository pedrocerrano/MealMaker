//
//  RecipeVC.swift
//  MealMaker
//
//  Created by iMac Pro on 3/2/23.
//

import UIKit

class RecipeVC: UIViewController {

    //MARK: - OUTLETS
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeAreaLabel: UILabel!
    @IBOutlet weak var recipeYouTubeLinkLabel: UILabel!
    @IBOutlet weak var recipeInsructionsLabel: UILabel!
    @IBOutlet weak var ingredientsTableView: UITableView!
    
    
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsTableView.dataSource = self
        ingredientsTableView.delegate = self
        fetchRecipe()
    }

    
    //MARK: - PROPERTIES
    var meal: Meal?
    var recipe: Recipe?
    
    
    //MARK: - FUNCTIONS
    func fetchRecipe() {
        guard let meal = meal else { return }
        MealService.fetchRecipe(forMeal: meal) { [weak self] result in
            switch result {
            case .success(let recipe):
                self?.recipe = recipe
                DispatchQueue.main.async { self?.updateUI(withRecipe: recipe) }
            case .failure(let error):
                print(error.errorDescription ?? Constants.Error.unknownError)
            }
        }
    }
    
    
    func updateUI(withRecipe recipe: Recipe) {
        recipeNameLabel.text        = recipe.mealName
        recipeAreaLabel.text        = recipe.mealAreaOfOrigin
        recipeYouTubeLinkLabel.text = recipe.youTubeLink
        recipeInsructionsLabel.text = recipe.instructions
        ingredientsTableView.reloadData()
        fetchRecipeImage()
    }
    
    
    func fetchRecipeImage() {
        MealService.fetchImage(for: recipe?.imageURL) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async { self?.recipeImageView.image = image }
            case .failure(let error):
                print(error.errorDescription ?? Constants.Error.unknownError)
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toInstructionsVC" {
            guard let recipe = recipe,
                  let destinationVC = segue.destination as? InstructionsVC else { return }
            destinationVC.instructions = recipe.instructions
        }
    }
    
} //: CLASS


//MARK: - EXT: TableView DataSource
extension RecipeVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe?.ingredients.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ingredientsTableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)
        
        guard let ingredient = recipe?.ingredients[indexPath.row] else { return UITableViewCell() }
        
        var config = cell.defaultContentConfiguration()
        config.text                 = ingredient.name
        config.secondaryText        = ingredient.measurement
        cell.contentConfiguration   = config
        
        return cell
    }
}
