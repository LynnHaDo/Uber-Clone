//
//  LocationSearchViewModel.swift
//  UberClone
//
//  Created by Do Linh on 1/13/25.
//

import MapKit
import Foundation

class LocationSearchViewModel: NSObject, ObservableObject {
    @Published var results = [MKLocalSearchCompletion]()
    @Published var selectedLocation: Location?
    @Published var pickupTime: String?
    @Published var dropOffTime: String?
    
    private let searchCompleter = MKLocalSearchCompleter()
    var queryFragment: String = "" {
        didSet {
            // print("Query fragment is: \(queryFragment)")
            searchCompleter.queryFragment = queryFragment
        }
    }
    
    var userLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }
    
    func locationSearch(for localSearchCompletion: MKLocalSearchCompletion,
                        completion: @escaping MKLocalSearch.CompletionHandler) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearchCompletion.title.appending(localSearchCompletion.subtitle)
        let search = MKLocalSearch(request: searchRequest)
        search.start(completionHandler: completion)
    }
    
    func selectLocation(_ location: MKLocalSearchCompletion) {
        locationSearch(for: location) { response, error in
            if let error = error {
                print("DEBUG: Failed to get location (Error: \(error.localizedDescription)).")
                return
            }
            
            guard let item = response?.mapItems.first else { return }
            self.selectedLocation = Location(title: location.title,
                                             coordinate: item.placemark.coordinate)
        }
        
    }
    
    func computeRidePrice(forType type: RideType) -> Double {
        guard let destination = selectedLocation?.coordinate else { return 0 }
        guard let start = self.userLocation else { return 0 }
        
        let userLocation = CLLocation(latitude: start.latitude,
                                      longitude: start.longitude)
        let destinationLocation = CLLocation(latitude: destination.latitude,
                                             longitude: destination.longitude)
        
        let tripDistanceInMeters = userLocation.distance(from: destinationLocation)
        return type.calculateFare(for: tripDistanceInMeters)
    }
    
    // Get a route from a given start and end
    func getRoute(from userLocation: CLLocationCoordinate2D,
                  to destination: CLLocationCoordinate2D,
                  completion: @escaping (MKRoute) -> Void) {
        let userPlacemark = MKPlacemark(coordinate: userLocation)
        let destinationPlacemark = MKPlacemark(coordinate: destination)
        let request = MKDirections.Request()
        
        request.source = MKMapItem(placemark: userPlacemark)
        request.destination = MKMapItem(placemark: destinationPlacemark)
        
        let direction = MKDirections(request: request)
        
        direction.calculate { response, error in
            if let error = error {
                print("DEBUG: Failed to get directions with error \(error.localizedDescription)")
                return
            }
            
            guard let route = response?.routes.first else { return }
            self.configurePickupAndDropoffTime(with: route.expectedTravelTime)
            completion(route)
        }
    }
    
    func configurePickupAndDropoffTime(with expectedTravelTime: Double) {
        self.pickupTime = Date().toTime()
        self.dropOffTime = (Date() + expectedTravelTime).toTime()
    }
}

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    // Get completion results
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
