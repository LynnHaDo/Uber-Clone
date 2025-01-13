//
//  MapViewRepresentable.swift
//  UberClone
//
//  Created by Do Linh on 12/20/24.
//

import SwiftUI
import MapKit

struct MapViewRepresentable: UIViewRepresentable {
    let mapView = MKMapView()
    let locationManager = LocationManager()
    
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    
    // Make a map view
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let selectedLocationCoordinate = locationViewModel.selectedLocationCoordinate {
            context.coordinator.addAndSelectAnnotation(for: selectedLocationCoordinate)
        }
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
}

extension MapViewRepresentable {
    // Provides the map view with functionalities from the map ui kit
    class MapCoordinator: NSObject, MKMapViewDelegate {
        // MARK: - Properties
        
        let parent: MapViewRepresentable
        
        // MARK: - Lifecycle
        
        init(parent: MapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        
        // MARK: - MKMapViewDelegate
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: userLocation.coordinate.latitude,
                    longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(
                    latitudeDelta: 0.05,
                    longitudeDelta: 0.05
                )
            )
            
            parent.mapView.setRegion(region, animated: true)
        }
        
        // MARK: - Helpers
        
        func addAndSelectAnnotation(for coordinate: CLLocationCoordinate2D) {
            // Remove all preexisiting annotation(s)
            self.parent.mapView.removeAnnotations(parent.mapView.annotations)
            
            // Create annotation for the given coordinate
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            self.parent.mapView.addAnnotation(annotation) // add it
            self.parent.mapView.selectAnnotation(annotation, animated: true) // select and animate the view
            
            // Zoom to the area containing the annotations
            self.parent.mapView.showAnnotations(self.parent.mapView.annotations, animated: true)
        }
    }
}
