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
    }
    
    private func setupViewControllers() {
        // Vista 1 - Pizzas
        let pizzasListTableViewController = PizzasListTableViewController(style: .insetGrouped)
        pizzasListTableViewController.tabBarItem.title = "Pizzas"
        pizzasListTableViewController.tabBarItem.image = UIImage(systemName: "pencil")
        let pizzasNavigationController = UINavigationController(rootViewController: pizzasListTableViewController)
        
        // Vista 2 - Pizzas favoritas
        // Sustituir esta vista por la de favoritos
        let favoritePizzasTableViewController = IngredientsListTableViewController(style: .insetGrouped)
        favoritePizzasTableViewController.tabBarItem.title = "Favoritos"
        favoritePizzasTableViewController.tabBarItem.image = UIImage(systemName: "star")
        let favoritePizzasNavigationController = UINavigationController(rootViewController: favoritePizzasTableViewController)
        
        // Vista 3 - Pizzerias
        let pizzeriasListTableViewController = PizzeriasListTableViewController(style: .insetGrouped)
        pizzeriasListTableViewController.tabBarItem.title = "Pizzerias"
        pizzeriasListTableViewController.tabBarItem.image = UIImage(systemName: "lizard")
        let pizzeriasNavigationController = UINavigationController(rootViewController: pizzeriasListTableViewController)
        
        viewControllers = [
            pizzasNavigationController,
            favoritePizzasNavigationController,
            pizzeriasNavigationController,
        ]
    }

}
