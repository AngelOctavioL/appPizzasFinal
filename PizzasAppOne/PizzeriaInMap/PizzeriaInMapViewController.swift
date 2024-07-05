//
//  PizzeriaInMapViewController.swift
//  PizzasAppOne
//
//  Created by Angel Octavio Lopez Cruz on 05/07/24.
//

import UIKit
import MapKit

class PizzeriaInMapViewController: UIViewController {
    // private var viewModel
    
    // creando el mapa
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.preferredConfiguration = MKHybridMapConfiguration()
        //mapView.showsUserLocation = true
        
        return mapView
    }()
    
    //present(PizzeriaInMapViewController(pizzeriaInMap: viewModel.pizzeriaLocation), animated: true)
    init(pizzeriaInMap: Pizzeria.Coordinates?) {
        print(pizzeriaInMap)
//        if let location = pokemonLocation {
//            let coordinate = CLLocationCoordinate2D(latitude: location.latitude,
//                                                    longitude: location.longitude)
//            viewModel = PokemonLocationViewModel(pokemonLocation: coordinate)
//        } else {
//            viewModel = PokemonLocationViewModel(pokemonLocation: nil)
//        }
        
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
        
        view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
