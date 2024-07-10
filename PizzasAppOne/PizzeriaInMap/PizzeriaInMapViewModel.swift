//
//  PizzeriaInMapViewModel.swift
//  PizzasAppOne
//
//  Created by Angel Octavio Lopez Cruz on 05/07/24.
//

import CoreLocation
import UIKit

protocol PizzeriaLocationViewModelDelegate where Self: UIViewController {
    func showPizzeriaLocation(coordinate: CLLocationCoordinate2D)
    func showRouteBetween(userLocation: CLLocationCoordinate2D, pizzeriaInMap: CLLocationCoordinate2D)
}

class PizzeriaInMapViewModel: NSObject {
    private let locationManager = CLLocationManager()
    private let pizzeriaInMap: CLLocationCoordinate2D?
    private var userLocation: CLLocationCoordinate2D?
    
    weak var delegate: PizzeriaLocationViewModelDelegate?
    
    init(pizzeriaInMap: CLLocationCoordinate2D?) {
        self.pizzeriaInMap = pizzeriaInMap
        super.init()
        setupLocationManager()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func shouldShowPizzeriaLocation() {
        guard let location = pizzeriaInMap else { return }
        delegate?.showPizzeriaLocation(coordinate: location)
    }
    
    func shouldShowDirectionsToPizzeria() {
        guard let userLocation, let pizzeriaInMap = pizzeriaInMap else {
            // MARK: el userLocation llega en nil
            //print(userLocation)
            print("User location or pizzeria location is missing.") // Debugging message
            return
        }
        
        delegate?.showRouteBetween(userLocation: userLocation, pizzeriaInMap: pizzeriaInMap)
    }
}

extension PizzeriaInMapViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        userLocation = coordinate
    }
}
