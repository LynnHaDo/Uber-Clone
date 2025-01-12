//
//  HomeView.swift
//  UberClone
//
//  Created by Do Linh on 12/20/24.
//

import SwiftUI

struct HomeView: View {
    @State private var showLocationSearchView: Bool = false;
    
    var body: some View {
        ZStack(alignment: .top) {
            MapViewRepresentable().ignoresSafeArea()
            
            
            if showLocationSearchView {
                ZStack {
                    Color.main.ignoresSafeArea()
                    LocationSearchView()
                        .padding(.top, 80)
                }
            } else {
                LocationActivationView()
                    .padding(.top, 80)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            showLocationSearchView.toggle()
                        }
                    }
            }
            
            MapToggler(showLocationSearchView: $showLocationSearchView)
                .padding(.leading)
                .padding(.top, 10)
                
        }
    }
}

#Preview {
    HomeView()
}
