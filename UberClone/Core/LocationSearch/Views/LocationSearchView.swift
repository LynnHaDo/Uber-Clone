//
//  LocationSearchView.swift
//  UberClone
//
//  Created by Do Linh on 1/11/25.
//

import SwiftUI

struct LocationSearchView: View {
    @State var currentLocation: String = ""
    @Binding var show: Bool
    
    @EnvironmentObject var viewModel: LocationSearchViewModel
    
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
                    
                    TextField("Destination", text: $viewModel.queryFragment)
                        .custom(backgroundColor: Color(.systemGray4))
                    
                }
            }
            .padding(.horizontal)
            
            // List of locations
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(viewModel.results, id: \.self) {
                        result in
                        
                        LocationSearchResultRow(
                            name: result.title,
                            address: result.subtitle
                        )
                        .onTapGesture {
                            withAnimation(.spring()) {
                                viewModel.selectLocation(result)
                                show.toggle()
                            }
                        }
                    }
                }
                
            }
            .padding()
        }
        .background(.main)
    }
}

#Preview {
    LocationSearchView(show: .constant(false))
}
