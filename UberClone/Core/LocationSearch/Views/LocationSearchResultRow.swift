//
//  LocationSearchResultRow.swift
//  UberClone
//
//  Created by Do Linh on 1/11/25.
//

import SwiftUI

struct LocationSearchResultRow: View {
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: "pin.circle.fill")
                .resizable()
                .foregroundStyle(.lightBlue)
                .tint(.white)
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Mount Holyoke College")
                    .font(.headline)
                    .frame(alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundStyle(.text)
                Text("50 College Street, MA 01075, United States")
                    .font(.subheadline)
                    .frame(alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundStyle(Color(.systemGray3))
                
                Divider()
                    .overlay(.text)
            }
            .padding(.leading, 8)
            .padding(.vertical, 8)
        }
        .padding(.horizontal)
    }
}

#Preview {
    LocationSearchResultRow()
}
