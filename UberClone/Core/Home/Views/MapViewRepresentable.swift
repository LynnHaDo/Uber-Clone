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
    let locationManager = LocationManager.shared
    @Binding var mapState: MapViewState
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
        // print("DEBUG: Map state is: \(mapState)")
        
        switch mapState {
            case .blank:
                context.coordinator.clearMapViewAndRecenter()
                break
            case .selectingLocation:
                break
            case .locationSelected:
                if let selectedLocationCoordinate = locationViewModel.selectedLocationCoordinate {
                    // Add the destination pin
                    context.coordinator.addAndSelectAnnotation(for: selectedLocationCoordinate)
                    // Get a polyline that represents the route
                    context.coordinator.configurePolyline(destination: selectedLocationCoordinate)
                }
                break
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
        var userLocationCoordinate: CLLocationCoordinate2D?
        var currentRegion: MKCoordinateRegion?
        
        // MARK: - Lifecycle
        
        init(parent: MapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        
        // MARK: - MKMapViewDelegate
        
        func mapView(_ mapView: MKMapView,
                     didUpdate userLocation: MKUserLocation) {
            self.userLocationCoordinate = userLocation.coordinate
            
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: userLocation.coordinate.latitude,
                    longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(
                    latitudeDelta: 0.05,
                    longitudeDelta: 0.05
                )
            )
            
            self.currentRegion = region // update the current region of interest
            self.parent.mapView.setRegion(region, animated: true)
        }
        
        // Draw the polyline onto the map
        func mapView(_ mapView: MKMapView, rendererFor overlay: any MKOverlay) -> MKOverlayRenderer {
            let routePolyline = MKPolylineRenderer(overlay: overlay)
            routePolyline.strokeColor = .main
            routePolyline.lineWidth = 6
            return routePolyline
        }
        
        // MARK: - Helpers
        
        // Add the coordinate of the destination to the map and zoom into region
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
        
        // Add a polyline of the route onto the map
        func configurePolyline(destination destCoordinate: CLLocationCoordinate2D) {
            guard let userLocationCoordinate = self.userLocationCoordinate else { return }
            // Remove any previous overlays
            self.parent.mapView.removeOverlays(self.parent.mapView.overlays)
            
            getRoute(from: userLocationCoordinate, to: destCoordinate) {
                route in
                let rect = self.parent.mapView.mapRectThatFits(
                    route.polyline.boundingMapRect,
                    edgePadding: .init(top: 80, left: 16, bottom: 550, right: 16)
                )
                self.parent.mapView.addOverlay(route.polyline)
                self.parent.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
            }
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
                completion(route)
            }
        }
        
        func clearMapViewAndRecenter() {
            // Remove all preexisiting annotation(s)
            self.parent.mapView.removeAnnotations(parent.mapView.annotations)
            
            // Remove any previous overlays
            self.parent.mapView.removeOverlays(self.parent.mapView.overlays)
            
            if let currentRegion = currentRegion {
                self.parent.mapView.setRegion(currentRegion, animated: true)
            }
        }
    }
}
