//
//  Utils.swift
//  TOWA Login
//
//  Created by Arthur Christopher Belmonte on 7/9/22.
//

import Foundation

class CredentialsUtils {
    
    static let kStoredUsername = "StoredUsername"
    static let kLoginState = "LoginState"
    static let kService = "password"
    static let kAccount = "towa"
    
    class func getUsername() -> String? {
        return UserDefaults.standard.string(forKey: kStoredUsername)
    }

    class func setUsername(username: String) {
        UserDefaults.standard.set(username, forKey: kStoredUsername)
        UserDefaults.standard.synchronize()
    }
    
    class func getPassword() -> String? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: kService,
            kSecAttrAccount: kAccount,
            kSecReturnData: true
        ] as CFDictionary
        
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        
        if let data = result as? Data {
            return String(data: data, encoding: .utf8)
        }
        
        return nil
    }
    
    class func setPassword(password: String) {
        let data = Data(password.utf8)
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: kService,
            kSecAttrAccount: kAccount,
            kSecValueData: data
        ] as CFDictionary
        
        // Save password to keychain
        let status = SecItemAdd(query, nil)
        
        // Update keychain if item already exists
        if status == errSecDuplicateItem {
            let query = [
                kSecClass: kSecClassGenericPassword,
                kSecAttrService: kService,
                kSecAttrAccount: kAccount,
            ] as CFDictionary

            let attributesToUpdate = [kSecValueData: data] as CFDictionary
            SecItemUpdate(query, attributesToUpdate)
        }
    }
    
    class func isUserLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: kLoginState)
    }
    
    class func setUserLoginState(loggedIn: Bool) {
        UserDefaults.standard.set(loggedIn, forKey: kLoginState)
        UserDefaults.standard.synchronize()
    }
    
    class func isUsernameValid(username: String?) -> Bool {
        // Check if username is greater than or equal to 3 characters and are alphanumeric
        if let username = username, username.count >= 3 && username.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) == nil {
            return true
        }
        
        return false
    }
    
    class func isPasswordValid(password: String?) -> Bool {
        // Check if password is greater than or equal to 8 characters, has 1 uppercase, has 1 lowercase, and has 1 numeric character
        if let password = password, password.count >= 8 {
            let uppercasePredicate = NSPredicate(format:"SELF MATCHES '.*[A-Z]+.*'")
            let lowercasePredicate = NSPredicate(format:"SELF MATCHES '.*[a-z]+.*'")
            let numberPredicate = NSPredicate(format:"SELF MATCHES '.*[0-9]+.*'")
            let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [uppercasePredicate, lowercasePredicate, numberPredicate])
            
            return predicate.evaluate(with: password)
        }
        
        return false
    }
    
}
