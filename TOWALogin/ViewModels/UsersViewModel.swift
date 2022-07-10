//
//  UsersViewModel.swift
//  TOWA Login
//
//  Created by Arthur Christopher Belmonte on 7/10/22.
//

import UIKit

class UsersViewModel {
    
    var users = [User]()
    
    func getUsers(success: @escaping () -> Void, failure: @escaping (String) -> Void) {
        UsersWebService().getUsers { usersData in
            self.users.removeAll()
            for userData in usersData {
                self.users.append(User(data: userData))
            }
            DispatchQueue.main.async {
                success()
            }
        } failure: { error in
            DispatchQueue.main.async {
                failure(error)
            }
        }
    }
    
    func numberOfRowsInSection() -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = users[indexPath.row]
        let bgView = UIView()
        bgView.backgroundColor = UIColor.init(red: 255/255, green: 168/255, blue: 0/255, alpha: 1.0)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCellIdentifier", for: indexPath)
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
        cell.textLabel?.text = user.name
        cell.selectedBackgroundView = bgView
        
        return cell
    }
    
    
}
