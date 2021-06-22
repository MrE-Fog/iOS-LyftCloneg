//
//  LocationAnnotation.swift
//  LyftClone
//
//  Created by Weerawut Chaiyasomboon on 12/6/2564 BE.
//

import Foundation
import MapKit

class LocationAnnotation: NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    let locationType: String
    
    init(coordinate: CLLocationCoordinate2D, locationType: String){
        self.coordinate = coordinate
        self.locationType = locationType
    }
}
