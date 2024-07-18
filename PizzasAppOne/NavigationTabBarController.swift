//
//  NavigationTabBarController.swift
//  PizzasAppOne
//
//  Created by Angel Octavio Lopez Cruz on 29/06/24.
//

import UIKit

class NavigationTabBarController: UITabBarController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewControllers()
        setupTabBarAppearance()
    }
    
    private func setupViewControllers() {
        // Vista 1 - Pizzas
        let pizzasListTableViewController = PizzasListTableViewController(style: .insetGrouped)
        pizzasListTableViewController.tabBarItem.title = "Pizzas"
        pizzasListTableViewController.tabBarItem.image = UIImage(systemName: "menucard")
        let pizzasNavigationController = UINavigationController(rootViewController: pizzasListTableViewController)
        
        // Vista 2 - Pizzas favoritas
        let favoritePizzasTableViewController = FavoritePizzasViewController()
        favoritePizzasTableViewController.tabBarItem.title = "Favoritos"
        favoritePizzasTableViewController.tabBarItem.image = UIImage(systemName: "star")
        let favoritePizzasNavigationController = UINavigationController(rootViewController: favoritePizzasTableViewController)
        
        // Vista 3 - Pizzerias
        let pizzeriasListTableViewController = PizzeriasListTableViewController(style: .insetGrouped)
        pizzeriasListTableViewController.tabBarItem.title = "Pizzerias"
        pizzeriasListTableViewController.tabBarItem.image = UIImage(systemName: "storefront")
        let pizzeriasNavigationController = UINavigationController(rootViewController: pizzeriasListTableViewController)
        
        viewControllers = [
            pizzasNavigationController,
            favoritePizzasNavigationController,
            pizzeriasNavigationController,
        ]
    }
    
    private func setupTabBarAppearance() {
        // Cambiar el color de los íconos seleccionados
        tabBar.tintColor = UIColor.highlightColor
        // Cambiar el color de los íconos no seleccionados
        //tabBar.unselectedItemTintColor = UIColor(hex: "#E08700")
    }
}
