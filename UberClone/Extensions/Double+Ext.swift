//
//  Double+Ext.swift
//  UberClone
//
//  Created by Do Linh on 1/23/25.
//

import Foundation

extension Double {
    func roundBy(_ fractionDigits: Int) -> Double {
        let multiplier = pow(10, Double(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
}
