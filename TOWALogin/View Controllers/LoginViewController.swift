//
//  LoginViewController.swift
//  TOWA Login
//
//  Created by Arthur Christopher Belmonte on 7/9/22.
//

import UIKit

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var usernameTextField: TWTextField!
    @IBOutlet weak var passwordTextField: TWTextField!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.title = "USERNAME"
        passwordTextField.title = "PASSWORD"
        passwordTextField.isSecureText = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Automatically log in user if already logged in
        if CredentialsUtils.isUserLoggedIn() {
            performSegue(withIdentifier: "ShowUsersViewControllerNoAnimation", sender: self)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        usernameTextField.text = ""
        passwordTextField.text = ""
    }
    
    // MARK: - Button tap methods
    @IBAction func loginButtonTapped(_ sender: Any) {
        self.view.endEditing(true)
        
        if usernameTextField.text == CredentialsUtils.getUsername() && passwordTextField.text == CredentialsUtils.getPassword() {
            CredentialsUtils.setUserLoginState(loggedIn: true)
            performSegue(withIdentifier: "ShowUsersViewController", sender: self)
        }
        else {
            showMessage(message: "Incorrect username or password")
        }
    }
    
}
