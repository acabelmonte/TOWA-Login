//
//  BaseViewController.swift
//  TOWA Login
//
//  Created by Arthur Christopher Belmonte on 7/9/22.
//

import UIKit
import Toast

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide resign responder when tapped outside the textfields
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        // Setup Toast style
        let style = CSToastManager.sharedStyle()
        style?.backgroundColor = UIColor.init(red: 255/255, green: 168/255, blue: 0/255, alpha: 1.0)
        style?.horizontalPadding = 40.0
        style?.verticalPadding = 12.0
        style?.messageNumberOfLines = 0
        style?.shadowOpacity = 0.3
        style?.displayShadow = true
        style?.messageFont = UIFont(name:"GeezaPro-Bold", size:17)
    }
    
    func showMessage(message: String) {
        self.view.makeToast(message, duration: 2.0, position: CSToastPositionTop)
    }
    
    func showLoading() {
        self.view.makeToastActivity(CSToastPositionCenter)
    }
    
    func hideLoading() {
        self.view.hideToast()
    }

}

// Move to VM
//        UsersWebService().getUsers { usersData in
//            var users = [User]()
//            for userData in usersData {
//                let user = User(data: userData)
//                users.append(user)
//            }
//        } failure: { error in
//            print(error)
//        }
