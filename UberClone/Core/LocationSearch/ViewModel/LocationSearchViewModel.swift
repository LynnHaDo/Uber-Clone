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
    @Published var selectedLocationCoordinate: CLLocationCoordinate2D?
    
    private let searchCompleter = MKLocalSearchCompleter()
    var queryFragment: String = "" {
        didSet {
            // print("Query fragment is: \(queryFragment)")
            searchCompleter.queryFragment = queryFragment
        }
    }
    
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
            self.selectedLocationCoordinate = item.placemark.coordinate
        }
        
    }
}

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    // Get completion results
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
