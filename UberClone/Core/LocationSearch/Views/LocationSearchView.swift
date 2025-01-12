//
//  LocationSearchView.swift
//  UberClone
//
//  Created by Do Linh on 1/11/25.
//

import SwiftUI

struct LocationSearchView: View {
    @State var currentLocation: String = ""
    @State var destination: String = ""
    
    var body: some View {
        VStack {
            // Header
            HStack(alignment: .center, spacing: 10) {
                VStack {
                    Circle()
                        .fill(Color(.systemGray2))
                        .frame(width: 8, height: 8)
                        .opacity(0.6)
                    
                    Rectangle()
                        .fill(Color(.systemGray2))
                        .frame(width: 1, height: 45)
                        .opacity(0.6)
                    
                    Circle()
                        .fill(.text)
                        .frame(width: 8, height: 8)
                    
                }
                
                VStack {
                    TextField("Current location", text: $currentLocation)
                        .custom(backgroundColor: Color(.systemGroupedBackground))
                        .padding(.bottom, 17)
                    
                    TextField("Current location", text: $currentLocation)
                        .custom(backgroundColor: Color(.systemGray4))
                    
                }
            }
            .padding(.horizontal)
            
            // List of locations
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(0..<10, id: \.self) {
                        _ in
                        
                        LocationSearchResultRow()
                    }
                }
                
            }
            .padding()
        }
        .background(.main)
    }
}

#Preview {
    LocationSearchView()
}
