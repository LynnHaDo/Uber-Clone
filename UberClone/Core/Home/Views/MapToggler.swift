//
//  MapToggler.swift
//  UberClone
//
//  Created by Do Linh on 1/11/25.
//

import SwiftUI

struct MapToggler: View {
    @Binding var showLocationSearchView: Bool
    
    var body: some View {
        HStack {
            Button {
                withAnimation(.spring()) {
                    showLocationSearchView.toggle()
                }
            } label: {
                Image(systemName: showLocationSearchView ? "arrow.left" : "line.3.horizontal")
                    
                    .frame(width: 16, height: 16)
                    .foregroundColor(.black)
                    .padding()
                    .rounded()
            }
            
            Spacer()
        }
    }
}
