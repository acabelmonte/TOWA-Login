//
//  UsersViewController.swift
//  TOWA Login
//
//  Created by Arthur Christopher Belmonte on 7/10/22.
//

import UIKit

class UsersViewController: BaseViewController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.showLoading()
    }
    
    // MARK: - Button tap methods
    @IBAction func logoutButtonTapped(_ sender: Any) {
        CredentialsUtils.setUserLoginState(loggedIn: false)
        dismiss(animated: true)
    }
    
}
