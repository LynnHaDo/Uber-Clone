//
//  MapToggler.swift
//  UberClone
//
//  Created by Do Linh on 1/11/25.
//

import SwiftUI

struct MapToggler: View {
    @Binding var mapState: MapViewState
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    
    func handlerFor(_ state: MapViewState) {
        switch state {
        case .blank:
            print("DEBUG: Default state")
        case .selectingLocation:
            mapState = .blank
        case .locationSelected, .polylineAdded:
            mapState = .blank
            locationViewModel.selectedLocation = nil
        }
    }
    
    func imageFor(_ state: MapViewState) -> String {
        switch state {
        case .selectingLocation, .locationSelected:
            return "arrow.left"
        default:
            return "line.3.horizontal"
        }
    }
    
    var body: some View {
        HStack {
            Button {
                withAnimation(.spring()) {
                    handlerFor(mapState)
                }
            } label: {
                Image(systemName: imageFor(mapState))
                    .frame(width: 16, height: 16)
                    .foregroundColor(.black)
                    .padding()
                    .rounded()
            }
            
            Spacer()
        }
    }
}
