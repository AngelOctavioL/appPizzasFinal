//
//  PizzasListTableViewModel.swift
//  PizzasAppOne
//
//  Created by Angel Octavio Lopez Cruz on 29/06/24.
//

import Foundation

class PizzeriasListTableViewModel {
    private let pizzeriaDataFileName = "pizza-info"
    private let pizzeriaDataFileExtension = "json"
    
    private var pizzeriasList = [Pizzeria]()
    
    let cellIdentifier = "PizzeriaCell"
    let title = "Pizzeria"
    var pizzeriaCount: Int { pizzeriasList.count }
    
    init() {
        if let pizzaInfo = loadPizzeriasInfo() {
            pizzeriasList = pizzaInfo.pizzerias
        }
    }
    
    func loadPizzeriasInfo() -> PizzaInfo? {
        if let url = Bundle.main.url(forResource: pizzeriaDataFileName, withExtension: pizzeriaDataFileExtension) {
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
    
    func pizzeria(at indexPath: IndexPath) -> Pizzeria {
        pizzeriasList[indexPath.row]
    }
}
