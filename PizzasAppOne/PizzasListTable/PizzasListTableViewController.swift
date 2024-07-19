//
//  PizzasListTableViewController.swift
//  PizzasAppOne
//
//  Created by Angel Octavio Lopez Cruz on 29/06/24.
//

import UIKit

class PizzasListTableViewController: UITableViewController {
    let viewModel = PizzasListTableViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
        // Para cambiar el color del titulo del navigation
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.primaryTextColor]
        // para cambiar el color del texto y la fecha del navigation
        navigationController?.navigationBar.tintColor = UIColor.red
        tableView.backgroundColor = UIColor.pizzaCrust // o UIColor.primaryColor
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: viewModel.cellIdentifier)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.pizzasCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier, for: indexPath)
        let pizza = viewModel.pizza(at: indexPath)
        var cellConfigurator = cell.defaultContentConfiguration()
        cellConfigurator.text = pizza.name
        cellConfigurator.textProperties.color = UIColor.olives
        cell.contentConfiguration = cellConfigurator
        // Cambiar el color de fondo de la celda utilizando un código hexadecimal con alpha
        //cell.backgroundColor = UIColor(hex: "#FFF7EB")
        cell.backgroundColor = UIColor.pizzaCrust
        cell.accessoryType = .disclosureIndicator

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedPizza = viewModel.pizza(at: indexPath)
        let ingredientsOfPizza = IngredientsOfPizzasTableViewController(pizza: selectedPizza)
        
        navigationController?.pushViewController(ingredientsOfPizza, animated: true)
    }
}
