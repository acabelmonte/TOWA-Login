//
//  UserDetailsViewController.swift
//  TOWA Login
//
//  Created by Arthur Christopher Belmonte on 7/10/22.
//

import UIKit

class UserDetailsViewController: BaseViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companyBsLabel: UILabel!
    @IBOutlet weak var catchPhraseLabel: UILabel!
    
    var user: User?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.tintColor = yellowColor
        nameLabel.text = user?.name
        usernameLabel.text = user?.username
        emailLabel.text = user?.email
        phoneLabel.text = user?.phone
        websiteLabel.text = user?.website
        
        if let address = user?.address {
            addressLabel.text = "\(address.suite ?? "") \(address.street ?? ""), \(address.city ?? ""), \(address.zipcode ?? "")"
        }
        
        if let company = user?.company {
            companyNameLabel.text = company.name
            companyBsLabel.text = company.bs
            catchPhraseLabel.text = "\"\(company.catchPhrase ?? "")\""
        }
    }
    
    // MARK: - Button tap methods
    @IBAction func logoutButtonTapped(_ sender: Any) {
        CredentialsUtils.setUserLoginState(loggedIn: false)
        navigationController?.dismiss(animated: true)
    }

    @IBAction func locationButtonTapped(_ sender: Any) {
        print("location")
    }
    
}
