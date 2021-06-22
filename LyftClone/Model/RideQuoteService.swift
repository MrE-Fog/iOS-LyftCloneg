//
//  RideQuoteService.swift
//  LyftClone
//
//  Created by Weerawut Chaiyasomboon on 9/6/2564 BE.
//

import Foundation
import CoreLocation

class RideQuoteService{
    static let shared = RideQuoteService()
    
    private init() {
        
    }
    
    func getQuotes(pickUpLocation: Location, dropOffLocation: Location) -> [RideQuote]{
        
        let location1 = CLLocation(latitude: pickUpLocation.lat, longitude: pickUpLocation.lng)
        let location2 = CLLocation(latitude: dropOffLocation.lat, longitude: dropOffLocation.lng)
        
        // Meters
        let distance = location1.distance(from: location2)
        let minimumAmount = 3.0
        
        return [
            RideQuote(thumbnail: "ride-shared", name: "Shared", capacity: "1-2", price: minimumAmount + (distance * 0.005), time: Date()),
            RideQuote(thumbnail: "ride-compact", name: "Compact", capacity: "4", price: minimumAmount + (distance * 0.009), time: Date()),
            RideQuote(thumbnail: "ride-large", name: "Large", capacity: "6", price: minimumAmount + (distance * 0.015), time: Date())
        ]
    }
}
