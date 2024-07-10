//
//  IngredientsOfPizzasTableViewController.swift
//  PizzasAppOne
//
//  Created by Angel Octavio Lopez Cruz on 03/07/24.
//

import UIKit
import Lottie

class IngredientsOfPizzasTableViewController: UITableViewController {
    private let viewModel: IngredientsOfPizzasTableViewModel
    
    private lazy var animationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "animationPizza")
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        
        return animationView
    }()
    
    init(pizza: Pizza) {
        viewModel = IngredientsOfPizzasTableViewModel(with: pizza)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.pizzaName
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: viewModel.cellIdentifier)
        
        // Añadir la vista de la animación
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            animationView.widthAnchor.constraint(equalToConstant: 300),
            animationView.heightAnchor.constraint(equalToConstant: 300),
        ])
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.ingredientsOfPizzasCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier, for: indexPath)
        
        let ingredients = viewModel.ingredient(at: indexPath)
        var cellConfigurator = cell.defaultContentConfiguration()
        cellConfigurator.text = ingredients
        cell.contentConfiguration = cellConfigurator
        
        return cell
    }
}
