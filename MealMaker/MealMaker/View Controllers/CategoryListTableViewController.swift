//
//  CategoryListTableViewController.swift
//  MealMaker
//
//  Created by iMac Pro on 3/1/23.
//

import UIKit

class CategoryListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllCatgories()
    }

    
    //MARK: - PROPERTIES
    var categoryArray: [Category] = []
    
    
    //MARK: - FUNCTIONS
    func fetchAllCatgories() {
        MealService.fetchAllCategories { [weak self] result in
            switch result {
            case .success(let categories):
                self?.categoryArray = categories
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error.errorDescription ?? Constants.Error.unknownError)
            }
        }
    }
    
    
    func configureCell(cell: UITableViewCell, category: Category) {
        var config                          = cell.defaultContentConfiguration()
        config.text                         = category.categoryName
        config.textProperties.font          = UIFont.systemFont(ofSize: 20, weight: .bold)
        config.secondaryText                = category.categoryDescription
        config.secondaryTextProperties.font = UIFont.systemFont(ofSize: 14, weight: .light)
        cell.contentConfiguration = config
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)

        let category = categoryArray[indexPath.row]
        configureCell(cell: cell, category: category)

        return cell
    }


    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
}
