//
//  LocationSearchResultRow.swift
//  UberClone
//
//  Created by Do Linh on 1/11/25.
//

import SwiftUI

struct LocationSearchResultRow: View {
    let name: String
    let address: String
    
    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            Image(systemName: "pin.circle.fill")
                .resizable()
                .foregroundStyle(.lightBlue)
                .tint(.white)
                .frame(width: 40, height: 40)
                .padding(.trailing, 8)
            
            VStack(alignment: .leading, spacing: 4) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(name)
                        .headline()
                        .frame(alignment: .leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundStyle(.text)
                    Text(address)
                        .regular()
                        .frame(alignment: .leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundStyle(Color(.systemGray3))
                }
                .padding(.vertical, 8)
                
                Divider()
                    .overlay(.text)
                    .padding(.vertical, 8)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    LocationSearchResultRow(name: "Mount Holyoke College", address: "50 College Street, MA 01075, United States")
}
