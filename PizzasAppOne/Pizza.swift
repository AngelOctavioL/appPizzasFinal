//
//  Pizzas.swift
//  PizzasAppOne
//
//  Created by Angel Octavio Lopez Cruz on 29/06/24.
//

import Foundation

struct Pizzeria: Codable {
    struct Coordinates: Codable {
        let latitude: Double?
        let longitude: Double?
    }
    
    let name: String
    let address: String
    let coordinates: Coordinates?
}

struct Pizza: Codable {
    let name: String
    let ingredients: [String]
}

struct PizzaInfo: Codable {
    let pizzerias: [Pizzeria]
    let pizzas: [Pizza]
    let ingredients: [String]
}

