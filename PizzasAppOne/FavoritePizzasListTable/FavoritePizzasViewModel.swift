//
//  FavoritePizzasListTableViewModel.swift
//  PizzasAppOne
//
//  Created by Angel Octavio Lopez Cruz on 29/06/24.
//

import Foundation

class FavoritePizzasViewModel {
    private let pizzaFavoriteDataFileName = "favoritesPizzas"
    private let pizzaFavoriteDataFileExtension = "json"
    
    private(set) var pizzaFavoriteList = [Pizza]()
    
    let cellIdentifier = "PizzaFavoriteCell"
    var pizzasFavoriteCount: Int { pizzaFavoriteList.count }
    
    func loadFavoritePizzaInfo(completion: @escaping ([Pizza]) -> Void) {
        DispatchQueue.global(qos: .background).async {
            guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                DispatchQueue.main.async {
                    completion([])
                }
                return
            }
            
            let fileURL = documentsDirectory.appendingPathComponent("\(self.pizzaFavoriteDataFileName).\(self.pizzaFavoriteDataFileExtension)")
            
            do {
                let data = try Data(contentsOf: fileURL)
                let pizzaInfo = try JSONDecoder().decode([Pizza].self, from: data)
                DispatchQueue.main.async {
                    completion(pizzaInfo)
                }
            } catch {
                print("Error al cargar el archivo JSON: \(error)")
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }
    }
    
    func pizzaFavorite(at indexPath: IndexPath) -> Pizza {
        pizzaFavoriteList[indexPath.row]
    }
    
    func updatePizzaFavoriteList(with pizzas: [Pizza]) {
        self.pizzaFavoriteList = pizzas
    }
    
    func removePizzaFavorite(at indexPath: IndexPath) {
        pizzaFavoriteList.remove(at: indexPath.row)
    }
}
