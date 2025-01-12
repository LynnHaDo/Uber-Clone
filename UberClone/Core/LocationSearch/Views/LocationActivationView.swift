//
//  LocationActivationView.swift
//  UberClone
//
//  Created by Do Linh on 1/11/25.
//

import SwiftUI

struct LocationActivationView: View {
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .frame(width: 8, height: 8)
                .padding(.horizontal, 18)
            
            Text("Where to?")
            
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - 64, height: 50)
        .foregroundStyle(Color.gray)
        .rounded()
    }
}

#Preview {
    LocationActivationView()
}
