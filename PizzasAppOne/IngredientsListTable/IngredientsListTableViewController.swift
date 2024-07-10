//
//  IngredientsListTableViewController.swift
//  PizzasAppOne
//
//  Created by Angel Octavio Lopez Cruz on 29/06/24.
//

import UIKit

class IngredientsListTableViewController: UIViewController {
    let viewModel = IngredientsListTableViewModel()
    var selectedIngredients = [String]()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: viewModel.cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private lazy var doneButton: UIButton = {
        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.title = "Done"
        let button = UIButton(configuration: buttonConfiguration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        view.addSubview(doneButton)
            
        NSLayoutConstraint.activate([
            // Configuración de la tabla para que ocupe la mayor parte de la vista
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: doneButton.topAnchor, constant: -16),
                
            // Configuración del botón "Done"
            doneButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            doneButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
        
    @objc private func doneButtonTapped() {
        // Acciones a realizar cuando se presiona el botón "Done"
        let alertController = UIAlertController(title: "Name Your Pizza", message: "Enter a name for your pizza", preferredStyle: .alert)
                
        alertController.addTextField { textField in textField.placeholder = "Pizza Name" }
                
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            guard let self = self else { return }
            
            if let pizzaName = alertController.textFields?.first?.text, !pizzaName.isEmpty {
                // Aquí puedes manejar el nombre de la pizza y los ingredientes seleccionados
                print("Pizza name: \(pizzaName)")
                print("Selected ingredients: \(self.selectedIngredients)")
                
                guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory,
                                                                        in: .userDomainMask).first
                else { return }
                
                let filename = "favoritesPizzas.json"
                let fileURL = documentsDirectory.appending(component: filename)
                var favoritePizzas: [Pizza] = []
                
                // Leer pizzas existentes
                if let data = try? Data(contentsOf: fileURL) {
                    favoritePizzas = (try? JSONDecoder().decode([Pizza].self, from: data)) ?? []
                }
                                
                // Agregar nueva pizza
                let newPizza = Pizza(name: pizzaName, ingredients: self.selectedIngredients)
                favoritePizzas.append(newPizza)
                                
                // Guardar pizzas actualizadas
                do {
                    let favoritePizzaData = try JSONEncoder().encode(favoritePizzas)
                    try favoritePizzaData.write(to: fileURL)
                } catch {
                    assertionFailure("Failed storing favorite pizza")
                }
                                
                self.navigationController?.popViewController(animated: true)
            } else {
                // Muestra un mensaje de error si el campo de texto está vacío
                let errorAlert = UIAlertController(title: "Error", message: "The pizza name cannot be empty", preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(errorAlert, animated: true, completion: nil)
            }
        }
                
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
                
        present(alertController, animated: true, completion: nil)
    }
}

extension IngredientsListTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.ingredientsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier, for: indexPath)

        let ingredients = viewModel.ingredients(at: indexPath)
        var cellConfigurator = cell.defaultContentConfiguration()
        cellConfigurator.text = ingredients
        cell.contentConfiguration = cellConfigurator
        
        // Cambia el color de fondo si el ingrediente está seleccionado
        if selectedIngredients.contains(ingredients) {
            cell.backgroundColor = UIColor.systemGreen
        } else {
            cell.backgroundColor = UIColor.clear
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
            
        let ingredient = viewModel.ingredients(at: indexPath)
            
        if let index = selectedIngredients.firstIndex(of: ingredient) {
            selectedIngredients.remove(at: index)
        } else {
            selectedIngredients.append(ingredient)
        }
        print(selectedIngredients)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
