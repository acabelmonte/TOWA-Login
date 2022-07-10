//
//  User.swift
//  TOWA Login
//
//  Created by Arthur Christopher Belmonte on 7/9/22.
//

import Foundation

class User {
    
    var id = 0
    var name: String?
    var username: String?
    var email: String?
    var phone: String?
    var website: String?
    var address: Address?
    var company: Company?
    
    init(data: [String: Any]) {
        id = data["id"] as? Int ?? 0
        name = data["name"] as? String
        username = data["username"] as? String
        email = data["email"] as? String
        phone = data["phone"] as? String
        website = data["website"] as? String
        
        if let addressDict = data["address"] as? [String: Any] {
            address = Address(data: addressDict)
        }
        
        if let companyDict = data["company"] as? [String: Any] {
            company = Company(data: companyDict)
        }
    }
    
}

