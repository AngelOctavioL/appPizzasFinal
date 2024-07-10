//
//  PizzeriaInMapViewController.swift
//  PizzasAppOne
//
//  Created by Angel Octavio Lopez Cruz on 05/07/24.
//

import UIKit
import MapKit
import CoreLocation

class PizzeriaInMapViewController: UIViewController {

    // creando el mapa
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.preferredConfiguration = MKHybridMapConfiguration()
        mapView.showsUserLocation = true
        
        return mapView
    }()
    
    private lazy var closeMapButton: UIButton = {
        let button = UIButton()
        button.setTitle("Close", for: .normal)
        button.backgroundColor = .systemPurple
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeMapButtonTapped), for: .touchUpInside)
        // Redondear los bordes del botón
        // Ajustar el valor para obtener el nivel de redondez
        button.layer.cornerRadius = 10
        // Asegura que los subviews se recorten según el corner radius
        button.layer.masksToBounds = true
        
        return button
    }()
    
    private lazy var showPizzeriaButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Show Pizza place"
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showPizzeriaButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var showDirectionsButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Show directions"
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showDirectionsToPizzeria), for: .touchUpInside)

        return button
    }()
    
    private var viewModel: PizzeriaInMapViewModel
    
    init(pizzeriaInMap: Pizzeria.Coordinates?) {
        if let location = pizzeriaInMap {
            let coordinate = CLLocationCoordinate2D(latitude: location.latitude!, longitude: location.longitude!)
            viewModel = PizzeriaInMapViewModel(pizzeriaInMap: coordinate)
        } else {
            viewModel = PizzeriaInMapViewModel(pizzeriaInMap: nil)
        }
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        mapView.delegate = self
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(mapView)
        view.addSubview(closeMapButton)
        
        let pizzeriaInteractionStackView = UIStackView()
        pizzeriaInteractionStackView.translatesAutoresizingMaskIntoConstraints = false
        pizzeriaInteractionStackView.axis = .horizontal
        pizzeriaInteractionStackView.distribution = .fillProportionally
        
        pizzeriaInteractionStackView.addArrangedSubview(showPizzeriaButton)
        pizzeriaInteractionStackView.addArrangedSubview(showDirectionsButton)
        view.addSubview(pizzeriaInteractionStackView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            closeMapButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            closeMapButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            closeMapButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            pizzeriaInteractionStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            pizzeriaInteractionStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc
    private func closeMapButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    private func showPizzeriaButtonTapped() {
        viewModel.shouldShowPizzeriaLocation()
    }
    
    @objc
    private func showDirectionsToPizzeria() {
        viewModel.shouldShowDirectionsToPizzeria()
    }
}

extension PizzeriaInMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: any MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .red
        renderer.lineWidth = 10.0

        return renderer
    }
}

extension PizzeriaInMapViewController: PizzeriaLocationViewModelDelegate {
    func showPizzeriaLocation(coordinate: CLLocationCoordinate2D) {
        let pizzeriaAnnotation = MKPointAnnotation()
        pizzeriaAnnotation.coordinate = coordinate
        
        mapView.addAnnotation(pizzeriaAnnotation)
        
        let mapRegion = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        mapView.region = mapRegion
    }
    
    func showRouteBetween(userLocation: CLLocationCoordinate2D, pizzeriaInMap: CLLocationCoordinate2D) {
        let directionsRequest = MKDirections.Request()
        
        directionsRequest.source = MKMapItem(placemark: MKPlacemark(coordinate: userLocation))
        directionsRequest.destination = MKMapItem(placemark: MKPlacemark(coordinate: pizzeriaInMap))
        
        directionsRequest.transportType = .walking
        
        let directions = MKDirections(request: directionsRequest)
        
        directions.calculate {[weak self] response, error in
            guard  error == nil,
                   let response,
                   let route = response.routes.first
            else { return }
            
            self?.mapView.addOverlay(route.polyline)
        }
    }
}
