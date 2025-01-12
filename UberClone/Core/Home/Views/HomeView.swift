//
//  HomeView.swift
//  UberClone
//
//  Created by Do Linh on 12/20/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack(alignment: .top) {
            MapViewRepresentable().ignoresSafeArea()
            
            
            VStack(alignment: .leading) {
                MapToggler()
                
                LocationActivationView()
                    .padding(.top, 20)
            }
        }
    }
}

#Preview {
    HomeView()
}
