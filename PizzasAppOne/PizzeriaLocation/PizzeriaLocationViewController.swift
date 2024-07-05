//
//  PizzeriaLocationViewController.swift
//  PizzasAppOne
//
//  Created by Angel Octavio Lopez Cruz on 04/07/24.
//

import UIKit

class PizzeriaLocationViewController: UIViewController {
    private let viewModel: PizzeriaLocationViewModel
    
    // Preguntar por que se crea el scrollView
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
    
    // Creando un label para renderizar el nombre de la pizzeria
    private lazy var pizzeriaName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = viewModel.pizzeriaName
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.adjustsFontForContentSizeCategory = true
        
        label.accessibilityLabel = nil
        
        return label
    }()
    
    private lazy var pizzeriaLocationButton: UIButton = {
        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.title = "Pizzeria Location"
        
        return UIButton(configuration: buttonConfiguration)
    }()
    
    init(pizzeria: Pizzeria) {
        viewModel =  PizzeriaLocationViewModel(with: pizzeria)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        let pizzeriaInfoStack = UIStackView()
        pizzeriaInfoStack.translatesAutoresizingMaskIntoConstraints = false
        pizzeriaInfoStack.axis = .vertical
        pizzeriaInfoStack.distribution = .fillProportionally
        
        pizzeriaInfoStack.addArrangedSubview(pizzeriaName)
        pizzeriaInfoStack.addArrangedSubview(pizzeriaLocationButton)
        
        contentView.addSubview(pizzeriaInfoStack)
        
        NSLayoutConstraint.activate([
            pizzeriaInfoStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            pizzeriaInfoStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            pizzeriaInfoStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            pizzeriaInfoStack.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
        ])
        
        pizzeriaLocationButton.addTarget(self, action: #selector(locationButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func locationButtonTapped() {
        present(PizzeriaInMapViewController(pizzeriaInMap: viewModel.pizzeriaLocation), animated: true)
    }
}
