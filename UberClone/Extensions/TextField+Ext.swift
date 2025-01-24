//
//  TextField.swift
//  UberClone
//
//  Created by Do Linh on 1/11/25.
//

import SwiftUI

extension TextField {
    func custom(textColor: Color = Color.gray,
                backgroundColor: Color = Color.white) -> some View {
        return self.frame(width: UIScreen.main.bounds.width - 64, height: 50)
                    .foregroundStyle(textColor)
                    .padding(.horizontal, 10)
                    .rounded(background: backgroundColor)
    }
}
