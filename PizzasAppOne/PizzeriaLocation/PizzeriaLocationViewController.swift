//
//  PizzeriaLocationViewController.swift
//  PizzasAppOne
//
//  Created by Angel Octavio Lopez Cruz on 04/07/24.
//

import UIKit
import Lottie

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
    
    // Label para renderizar la direccion de la pizaria
    private lazy var pizzariaAddres: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = viewModel.pizzeriaAddres
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        
        return label
    }()
    
    // Boton para disparar el mapa
    private lazy var pizzeriaLocationButton: UIButton = {
        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.title = "Pizzeria Location"
        
        return UIButton(configuration: buttonConfiguration)
    }()
    
    private lazy var animationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "animationDelivery")
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()

        return animationView
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
        pizzeriaLocationButton.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        contentView.addSubview(pizzeriaName)
        contentView.addSubview(pizzariaAddres)
        contentView.addSubview(animationView)
        contentView.addSubview(pizzeriaLocationButton)
        
        NSLayoutConstraint.activate([
            pizzeriaName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            pizzeriaName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            pizzeriaName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            pizzariaAddres.topAnchor.constraint(equalTo: pizzeriaName.bottomAnchor, constant: 16),
            pizzariaAddres.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            pizzariaAddres.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            animationView.topAnchor.constraint(equalTo: pizzariaAddres.bottomAnchor, constant: 8),
            animationView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            // MARK: Preguntar por que la linea de abajo si se descomenta "jala" todos los elementos hacia el centro
            //animationView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            animationView.heightAnchor.constraint(equalToConstant: 350),
            animationView.widthAnchor.constraint(equalToConstant: 350),
            
            pizzeriaLocationButton.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 16),
            pizzeriaLocationButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            pizzeriaLocationButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
        
        pizzeriaLocationButton.addTarget(self, action: #selector(locationButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func locationButtonTapped() {
        present(PizzeriaInMapViewController(pizzeriaInMap: viewModel.pizzeriaLocation), animated: true)
    }
}
