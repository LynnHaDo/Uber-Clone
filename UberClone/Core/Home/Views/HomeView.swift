//
//  HomeView.swift
//  UberClone
//
//  Created by Do Linh on 12/20/24.
//

import SwiftUI

struct HomeView: View {
    @State private var mapState = MapViewState.blank
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top) {
                MapViewRepresentable(mapState: $mapState)
                    .ignoresSafeArea()
                
                if mapState == .blank {
                    LocationActivationView()
                        .onTapGesture {
                            withAnimation(.spring()) {
                                mapState = .selectingLocation
                            }
                        }
                        .padding(.top, 80)
                }
                else if mapState == .selectingLocation {
                    ZStack {
                        Color.main.ignoresSafeArea()
                        LocationSearchView(mapState: $mapState)
                            .padding(.top, 80)
                    }
                }
                else if mapState == .locationSelected {
                    VStack { }
                        .padding(.top, 80)
                }
                
                MapToggler(mapState: $mapState)
                    .padding(.leading)
                    .padding(.top, 10)
                
            }
            
            if mapState == .locationSelected {
                RideRequestView()
                    .transition(.move(edge: .bottom)) // to move it up from the bottom edge
            }
        }
        .ignoresSafeArea(edges: [.bottom])
        .onReceive(LocationManager.shared.$userLocation) { location in
            if let location = location {
                locationViewModel.userLocation = location
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(LocationSearchViewModel())
}
