//
//  FavoritePizzasTableViewController.swift
//  PizzasAppOne
//
//  Created by Angel Octavio Lopez Cruz on 29/06/24.
//

import UIKit
import Lottie

class FavoritePizzasViewController: UIViewController {
    private let viewModel = FavoritePizzasViewModel()

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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: viewModel.cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self

        return tableView
    }()
    
    private lazy var animationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "animationCooking")
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()

        return animationView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        loadPizzas()
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
        contentView.addSubview(animationView)

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
                        
            animationView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            animationView.heightAnchor.constraint(equalToConstant: 350),
            animationView.widthAnchor.constraint(equalToConstant: 350)
        ])
        
        createNewPizzaButton.translatesAutoresizingMaskIntoConstraints = false
        createNewPizzaButton.addTarget(self, action: #selector(createNewPizza), for: .touchUpInside)
    }
    
    private func loadPizzas() {
        viewModel.loadFavoritePizzaInfo { [weak self] pizzas in
            guard let self = self else { return }
            self.viewModel.updatePizzaFavoriteList(with: pizzas)
            self.updateUI()
        }
    }
    
    private func updateUI() {
        if viewModel.pizzasFavoriteCount > 0 {
            tableView.isHidden = false
            animationView.isHidden = true
            tableView.reloadData()
        } else {
            tableView.isHidden = true
            animationView.isHidden = false
        }
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
        return viewModel.pizzasFavoriteCount
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier, for: indexPath)
        let pizza = viewModel.pizzaFavorite(at: indexPath)
        cell.textLabel?.text = pizza.name
        
        return cell
    }
        
    // MARK: - Table view delegate
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Handle the selection of a pizza
    }
}
