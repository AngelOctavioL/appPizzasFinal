//
//  IngredientsOfPizzasTableViewModel.swift
//  PizzasAppOne
//
//  Created by Angel Octavio Lopez Cruz on 04/07/24.
//

import Foundation

class IngredientsOfPizzasTableViewModel {
    private let pizza: Pizza
    private var ingredientsOfPizzasList = [String]()
    
    let cellIdentifier = "IngredientsOfPizzasCell"
    var ingredientsOfPizzasCount: Int { ingredientsOfPizzasList.count }
    
    var pizzaName: String { pizza.name }
    var pizzaIngredients: [String] { pizza.ingredients }
    
    init(with pizza: Pizza) {
        self.pizza = pizza
        ingredientsOfPizzasList = pizza.ingredients
    }
    
    func ingredient(at indexPath: IndexPath) -> String {
        ingredientsOfPizzasList[indexPath.row]
    }
}
