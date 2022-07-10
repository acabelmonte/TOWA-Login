//
//  RegistrationViewController.swift
//  TOWA Login
//
//  Created by Arthur Christopher Belmonte on 7/9/22.
//

import UIKit

class RegistrationViewController: BaseViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var usernameTextField: TWTextField!
    @IBOutlet weak var passwordTextField: TWTextField!
    @IBOutlet weak var confirmTextField: TWTextField!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.title = "USERNAME"
        passwordTextField.title = "PASSWORD"
        passwordTextField.isSecureText = true
        confirmTextField.title = "CONFIRM PASSWORD"
        confirmTextField.isSecureText = true
    }
    
    // MARK: - Button tap methods
    @IBAction func backButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func signupButtonTapped(_ sender: Any) {
        view.endEditing(true)
        
        if let errorMessage = validateFields() {
            showMessage(message: errorMessage)
        }
        else {
            showMessage(message: "Registration successful!")
            CredentialsUtils.setUsername(username: usernameTextField.text)
            CredentialsUtils.setPassword(password: passwordTextField.text)
            
            // Added delay to display the "Registration successful!" message before going back to LoginVC
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.dismiss(animated: true)
            }
        }
    }
    
    // MARK: - Internal methods
    private func validateFields() -> String? {
        if CredentialsUtils.isUsernameValid(username: usernameTextField.text) == false {
            return "Invalid username"
        }
        
        if usernameTextField.text == CredentialsUtils.getUsername() {
            return "Username already exists"
        }
        
        if CredentialsUtils.isPasswordValid(password: passwordTextField.text) == false {
            return "Password should contain 1 uppercase, 1 lowercase, and 1 numeric character"
        }
        
        if CredentialsUtils.isPasswordValid(password: confirmTextField.text) == false {
            return "Invalid confirm password"
        }
        
        if passwordTextField.text != confirmTextField.text {
            return "Password do not match"
        }
        
        return nil
    }
    
}
