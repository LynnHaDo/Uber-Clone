//
//  RideRequestView.swift
//  UberClone
//
//  Created by Do Linh on 1/16/25.
//

import SwiftUI

struct RideRequestView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \RideType.id, ascending: true)],
        animation: .default)
    private var types: FetchedResults<RideType>
    
    @State private var selectedRideType: Int = 1
    
    var body: some View {
        VStack {
            // View handle
            Capsule()
                .foregroundStyle(Color(.systemGray2))
                .frame(width: 48, height: 6)
                .padding()
            
            // Start vs destination
            HStack(alignment: .center, spacing: 15) {
                VStack {
                    Circle()
                        .fill(Color(.systemGray2))
                        .frame(width: 8, height: 8)
                        .opacity(0.6)
                    
                    Rectangle()
                        .fill(Color(.systemGray2))
                        .frame(width: 1, height: 27)
                        .opacity(0.6)
                    
                    Circle()
                        .fill(.text)
                        .frame(width: 8, height: 8)
                    
                }
                
                VStack {
                    HStack {
                        Text("Current location")
                            .regular()
                        Spacer()
                        Text("1:20 PM")
                            .small()
                    }
                    .padding(.bottom, 23)
                    
                    HStack {
                        Text("Destination")
                            .regular()
                            .fontWeight(.semibold)
                        Spacer()
                        Text("1:30 PM")
                            .small()
                    }
                    .foregroundStyle( Color(.systemGray4))
                }
            }
            .padding(.horizontal)
            
            Divider()
                .overlay(.text)
                .padding()
            
            // Ride type selection
            VStack {
                HStack {
                    Text("Suggested Rides")
                        .heading3()
                    Spacer()
                }
                
                ScrollView(.horizontal) {
                    HStack(spacing: 16) {
                        ForEach(types) {
                            type in
                            VStack(alignment: .leading) {
                                Image(type.name!)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 90)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(type.name!)
                                        .regular()
                                    Text("$\(String(format:"%.2f", type.baseFare))")
                                        .regular()
                                }
                                .fontWeight(.semibold)
                            }
                            .frame(width: 100)
                            .padding()
                            .scaleEffect(type.id == selectedRideType ? 1.1 : 1.0)
                            .roundedNoShadow(background: Color(type.id == selectedRideType ? .lightBlue : .gray ))
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    selectedRideType = Int(type.id)
                                }
                            }
                        }
                    }
                }
                .padding(.vertical, 8)
            }
            .padding(.horizontal)
            
            Divider()
                .overlay(.text)
                .padding()
            
            // Payment option
            HStack(spacing: 12) {
                Text("Visa")
                    .regular()
                    .fontWeight(.medium)
                    .padding(6)
                    .roundedNoShadow(background: .lightBlue)
                    .padding()
                
                Text("**** 1234")
                    .regular()
                Spacer()
                
                Image(systemName: "chevron.right")
                    .imageScale(.medium)
                    .padding()
            }
            .frame(height: 50)
            .roundedNoShadow(background: Color(.gray))
            .padding(.horizontal)
            
            
            // Request ride button
            Button {
                
            } label: {
                Text("Confirm ride")
                    .heading3()
                    .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                    .roundedNoShadow(background: Color.lightBlue)
            }
            .padding(.top)
            .padding(.bottom, 32)
            
        }
        .rounded(background: Color.main)
        .foregroundStyle(.text)
    }
}

#Preview {
    RideRequestView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
