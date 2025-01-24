//
//  Text.swift
//  UberClone
//
//  Created by Do Linh on 1/16/25.
//

import SwiftUI

extension Text {
    func title() -> some View {
        self.font(Font.custom("WorkSansRoman-Bold", size: 24))
            .textCase(.uppercase)
    }
    func heading1() -> some View {
        self.font(Font.custom("WorkSansRoman-Bold", size: 22))
            .textCase(.uppercase)
    }
    func heading2() -> some View {
        self.font(Font.custom("WorkSansRoman-SemiBold", size: 20))
            .textCase(.uppercase)
    }
    func heading3() -> some View {
        self.font(Font.custom("WorkSansRoman-Medium", size: 18))
            .textCase(.uppercase)
    }
    func headline() -> some View {
        self.font(Font.custom("WorkSansRoman-SemiBold", size: 18))
    }
    func regular() -> some View {
        self.font(Font.custom("WorkSans-Regular", size: 16))
    }
    func small() -> some View {
        self.font(Font.custom("WorkSans-Regular", size: 14))
    }
}
