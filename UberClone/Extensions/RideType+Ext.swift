//
//  RideType+Ext.swift
//  UberClone
//
//  Created by Do Linh on 1/23/25.
//

extension RideType {
    func calculateFare(for distanceInMeters: Double) -> Double {
        let distanceInMiles = distanceInMeters / 1600
        return distanceInMiles * self.ratePerMile + self.baseFare 
    }
}
