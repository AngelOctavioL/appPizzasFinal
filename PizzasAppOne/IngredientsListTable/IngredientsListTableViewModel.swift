//
//  IngredientsListTableViewModel.swift
//  PizzasAppOne
//
//  Created by Angel Octavio Lopez Cruz on 29/06/24.
//

import Foundation

class IngredientsListTableViewModel {
    private let ingredientsDataFileName = "pizza-info"
    private let ingredientsFileExtension = "json"
    
    private var ingredientsList = [String]()
    
    let cellIdentifier = "IngredientCell"
    let title = "Ingredientes"
    var ingredientsCount: Int { ingredientsList.count }
    
    init() {
        if let pizzaInfo = loadIngredientsInfo() {
            ingredientsList = pizzaInfo.ingredients
        }
    }
    
    func loadIngredientsInfo() -> PizzaInfo? {
        if let url = Bundle.main.url(forResource: ingredientsDataFileName, withExtension: ingredientsFileExtension) {
            do {
                let data = try Data(contentsOf: url)
                let pizzaInfo = try JSONDecoder().decode(PizzaInfo.self, from: data)
                return pizzaInfo
            } catch {
                print("Error al cargar el archivo JSON: \(error)")
            }
        }
        return nil
    }
    
    func ingredients(at indexPath: IndexPath) -> String {
        ingredientsList[indexPath.row]
    }
}
