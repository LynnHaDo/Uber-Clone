//
//  LocationManager.swift
//  UberClone
//
//  Created by Do Linh on 12/20/24.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    static let shared = LocationManager()
    @Published var userLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization() // request user permission
        locationManager.startUpdatingLocation() // update user's location
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        self.userLocation = location.coordinate
        
        locationManager.stopUpdatingLocation()
    }
}

