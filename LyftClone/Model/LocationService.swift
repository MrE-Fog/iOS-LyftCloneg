//
//  LocationService.swift
//  LyftClone
//
//  Created by Weerawut Chaiyasomboon on 9/6/2564 BE.
//

import Foundation

class LocationService {
    
    static let shared = LocationService()
    private var recentLocations = [Location]()
    
    private init() {
        let locationUrl = Bundle.main.url(forResource: "locations", withExtension: "json")!
        let data = try! Data(contentsOf: locationUrl)
        let decoder = JSONDecoder()
        recentLocations = try! decoder.decode([Location].self, from: data)
        
    }
    
    func getRecentLocations() -> [Location]{
        return recentLocations
    }
    
    
}
