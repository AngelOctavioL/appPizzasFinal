//
//  ColorPalette.swift
//  PizzasAppOne
//
//  Created by Angel Octavio Lopez Cruz on 16/07/24.
//

import UIKit

// MARK: - Paleta General:

// MARK: -  Color Primario (Pizza Dough):
// Hex: #D4A373
// Uso: Fondo de la tabla

// MARK: - Color Secundario (Tomato Sauce):
// Hex: #D00000
// Uso: Fondo de celdas seleccionadas

// MARK: - Color de Resaltado (Mozzarella Cheese):
// Hex: #FFDD00
// Uso: Resaltar botones o elementos importantes

// MARK: -  Color de Fondo Suave (Pizza Crust):
// Hex: #F1E0C5
// Uso: Fondo de vistas

// MARK: -  Color de Texto Principal (Olives):
// Hex: #6B4226
// Uso: Color de texto principal

// MARK: - Color de Texto Secundario (Basil):
// Hex: #2E8B57
// Uso: Color de texto secundario

// ---------------------------------------------------------

// MARK: - Paleta Basada en #FDC474:

// MARK: - Color Primario (Basado en #FDC474):
// Hex: #FDC474
// Uso: Fondo de la tabla

// MARK: - Color Secundario (Complementario):
// Hex: #475FDC
// Uso: Fondo de celdas seleccionadas

// MARK: - Color de Resaltado:
// Hex: #F56C42
// Uso: Resaltar botones o elementos importantes

// MARK: - Color de Fondo Suave:
// Hex: #FFF2D9
// Uso: Fondo de vistas

// MARK: - Color de Texto Principal:
// Hex: #383838
// Uso: Color de texto principal

// MARK: - Color de Texto Secundario:
// Hex: #6B4226
// Uso: Color de texto secundario

extension UIColor {
    // Paleta de colores principal
    static let pizzaDough = UIColor(hex: "#D4A373")
    static let tomatoSauce = UIColor(hex: "#D00000")
    static let mozzarellaCheese = UIColor(hex: "#FFDD00")
    static let pizzaCrust = UIColor(hex: "#F1E0C5")
    static let olives = UIColor(hex: "#6B4226")
    static let basil = UIColor(hex: "#2E8B57")
    
    // Paleta de colores alterna
    static let primaryColor = UIColor(hex: "#FDC474")
    static let secondaryColor = UIColor(hex: "#475FDC")
    static let highlightColor = UIColor(hex: "#F56C42")
    static let softBackgroundColor = UIColor(hex: "#FFF2D9")
    static let primaryTextColor = UIColor(hex: "#383838")
    static let secondaryTextColor = UIColor(hex: "#6B4226")
}
