//
//  UsersWebService.swift
//  TOWA Login
//
//  Created by Arthur Christopher Belmonte on 7/9/22.
//

import Foundation

class UsersWebService {
    
    let baseURL = "https://jsonplaceholder.typicode.com"
    
    func getUsers(success: @escaping ([[String: Any]]) -> Void, failure: @escaping (String) -> Void) {
        let url = URL(string: "\(baseURL)/users")!

        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            guard let data = data, error == nil else {
                failure(error?.localizedDescription ?? "Empty response")
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    success(json)
                }
                else {
                    failure(error?.localizedDescription ?? "Unable to deserialize JSON data.")
                }
            } catch let error as NSError {
                failure(error.localizedDescription)
            }
        }).resume()
    }
    
}
