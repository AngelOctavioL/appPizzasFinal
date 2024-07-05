//
//  PizzeriaLocationViewModel.swift
//  PizzasAppOne
//
//  Created by Angel Octavio Lopez Cruz on 04/07/24.
//

import Foundation

class PizzeriaLocationViewModel {
    private let pizzeria: Pizzeria
    
    var pizzeriaName: String { pizzeria.name }
    var pizzeriaAddres: String { pizzeria.address }
    var pizzeriaLocation: Pizzeria.Coordinates? { pizzeria.coordinates }
    
    // preguntar cual es la diferencia entre init(pizzeria: Pizzeria)
    init(with pizzeria: Pizzeria) {
        self.pizzeria = pizzeria
    }
}
