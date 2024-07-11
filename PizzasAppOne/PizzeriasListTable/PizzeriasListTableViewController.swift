//
//  PizzasListTableViewController.swift
//  PizzasAppOne
//
//  Created by Angel Octavio Lopez Cruz on 29/06/24.
//

import UIKit

class PizzeriasListTableViewController: UITableViewController {
    let viewModel = PizzeriasListTableViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
        //tableView.backgroundColor = UIColor(hex: "#FFDAA7")
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: viewModel.cellIdentifier)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.pizzeriaCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier, for: indexPath)

        let pizzeria = viewModel.pizzeria(at: indexPath)
        var cellConfigurator = cell.defaultContentConfiguration()
        cellConfigurator.text = pizzeria.name
        cellConfigurator.secondaryText = pizzeria.address
        cell.contentConfiguration = cellConfigurator
        //cell.backgroundColor = UIColor(hex: "#FFF7EB")

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedPizzeria =  viewModel.pizzeria(at: indexPath)
        print(selectedPizzeria)
        let pizzeriaStore =  PizzeriaLocationViewController(pizzeria: selectedPizzeria)

        navigationController?.pushViewController(pizzeriaStore, animated: true)
    }
}
