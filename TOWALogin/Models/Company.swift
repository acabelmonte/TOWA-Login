//
//  Company.swift
//  TOWA Login
//
//  Created by Arthur Christopher Belmonte on 7/9/22.
//

import Foundation

class Company {
    
    var name: String?
    var catchPhrase: String?
    var bs: String?
    
    init(data: [String: Any]) {
        name = data["name"] as? String
        catchPhrase = data["catchPhrase"] as? String
        bs = data["bs"] as? String
    }
    
}
