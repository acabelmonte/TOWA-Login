//
//  Geo.swift
//  TOWA Login
//
//  Created by Arthur Christopher Belmonte on 7/9/22.
//

import Foundation

class Geo {
    
    var lat: String?
    var lng: String?
    
    init(data: [String: Any]) {
        lat = data["lat"] as? String
        lng = data["lng"] as? String
    }
    
}
