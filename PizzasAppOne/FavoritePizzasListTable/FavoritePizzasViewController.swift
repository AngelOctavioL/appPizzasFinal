//
//  FavoritePizzasTableViewController.swift
//  PizzasAppOne
//
//  Created by Angel Octavio Lopez Cruz on 29/06/24.
//

import UIKit

class FavoritePizzasViewController: UIViewController {
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    // Se crea una vista en blanco
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private lazy var titleView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "My Pizzas"
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.adjustsFontForContentSizeCategory = true
        
        label.accessibilityLabel = nil
        
        return label
    }()
    
    private lazy var createNewPizzaButton: UIButton = {
        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.title = "Create Pizza"
        
        return UIButton(configuration: buttonConfiguration)
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private let pizzas = ["Pizza Margherita", "Pepperoni Pizza", "Hawaiian Pizza"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        let contentViewHeightAnchor = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        contentViewHeightAnchor.isActive = true
        contentViewHeightAnchor.priority = .required - 1
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
        
        contentView.addSubview(titleView)
        contentView.addSubview(createNewPizzaButton)
        contentView.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                    
            createNewPizzaButton.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 16),
            createNewPizzaButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            createNewPizzaButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                    
            tableView.topAnchor.constraint(equalTo: createNewPizzaButton.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
        createNewPizzaButton.translatesAutoresizingMaskIntoConstraints = false
        createNewPizzaButton.addTarget(self, action: #selector(createNewPizza), for: .touchUpInside)
    }
    
    @objc
    func createNewPizza() {
        let createNewPizzaView =  IngredientsListTableViewController()
        navigationController?.pushViewController(createNewPizzaView, animated: true)
    }
}

extension FavoritePizzasViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: - Table view data source
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pizzas.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = pizzas[indexPath.row]
        return cell
    }
        
    // MARK: - Table view delegate
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Handle the selection of a pizza
    }
}
