//
//  PizzasListTableViewModel.swift
//  PizzasAppOne
//
//  Created by Angel Octavio Lopez Cruz on 29/06/24.
//

import Foundation

//protocol PizzasListTableViewModelDelegate: AnyObject {
//    func shouldReloadInformation()
//}

class PizzasListTableViewModel {
    private let pizzaDataFileName = "pizza-info"
    private let pizzaDataFileExtension = "json"
    
    private var pizzaList = [Pizza]()
    
    let cellIdentifier = "PizzaCell"
    let title = "Pizzas"
    var pizzasCount: Int { pizzaList.count }
    
    init() {
        if let pizzaInfo = loadPizzaInfo() {
            pizzaList = pizzaInfo.pizzas
        }
    }
    
    func loadPizzaInfo() -> PizzaInfo? {
        if let url = Bundle.main.url(forResource: pizzaDataFileName, withExtension: pizzaDataFileExtension) {
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
    
    func pizza(at indexPath: IndexPath) -> Pizza {
        pizzaList[indexPath.row]
    }
}
