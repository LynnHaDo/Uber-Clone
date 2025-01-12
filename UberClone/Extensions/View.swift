//
//  View.swift
//  UberClone
//
//  Created by Do Linh on 1/11/25.
//

import SwiftUI

extension View {
    func rounded() -> some View {
        return self.background(
            Rectangle()
                .fill(Color.white)
                .clipShape(.rect(cornerRadius: 8))
                .shadow(color: .gray, radius: 3)
        )
    }
}
