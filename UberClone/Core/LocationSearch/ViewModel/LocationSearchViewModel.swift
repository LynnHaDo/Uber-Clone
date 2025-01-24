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
}

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    // Get completion results
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
