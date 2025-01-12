//
//  View.swift
//  UberClone
//
//  Created by Do Linh on 1/11/25.
//

import SwiftUI

extension View {
    func rounded(background: Color = Color.white) -> some View {
        return self.background(
            Rectangle()
                .fill(background)
                .clipShape(.rect(cornerRadius: 8))
                .shadow(color: .gray, radius: 3)
        )
    }
}
