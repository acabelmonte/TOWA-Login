//
//  Geo.swift
//  TOWA Login
//
//  Created by Arthur Christopher Belmonte on 7/9/22.
//

import Foundation

class Geo {
    
    var lat: Double = 0.0
    var lng: Double = 0.0
    
    init(data: [String: Any]) {
        if let latitude = data["lat"] as? String {
            lat = Double(latitude) ?? 0.0
        }
        
        if let longitude = data["lng"] as? String {
            lng = Double(longitude) ?? 0.0
        }
    }
    
}
