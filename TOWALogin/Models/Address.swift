//
//  Address.swift
//  TOWA Login
//
//  Created by Arthur Christopher Belmonte on 7/9/22.
//

import Foundation

class Address {
    
    var street: String?
    var suite: String?
    var city: String?
    var zipcode: String?
    var geo: Geo?
    
    init(data: [String: Any]) {
        street = data["street"] as? String
        suite = data["suite"] as? String
        city = data["city"] as? String
        zipcode = data["zipcode"] as? String
        
        if let geoDict = data["geo"] as? [String: Any] {
            geo = Geo(data: geoDict)
        }
    }
    
}
