//
//  Date+Ext.swift
//  UberClone
//
//  Created by Do Linh on 1/23/25.
//

import Foundation

extension Date {
    private var dateTimeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter
    }
    
    func toTime() -> String {
        return dateTimeFormatter.string(for: self) ?? ""
    }
}
