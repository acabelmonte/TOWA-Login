//
//  UsersViewController.swift
//  TOWA Login
//
//  Created by Arthur Christopher Belmonte on 7/10/22.
//

import UIKit

class UsersViewController: BaseViewController  {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = UsersViewModel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        allowAutoRotate = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showLoading()
        viewModel.getUsers {
            self.hideLoading()
            self.tableView.reloadData()
        } failure: { errorMessage in
            self.showMessage(message: errorMessage)
        }
    }
    
    // MARK: - Button tap methods
    @IBAction func logoutButtonTapped(_ sender: Any) {
        CredentialsUtils.setUserLoginState(loggedIn: false)
        navigationController?.dismiss(animated: true)
    }
    
}

extension UsersViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.tableView(tableView, cellForRowAt: indexPath)
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userDetailsVC = storyboard?.instantiateViewController(withIdentifier: "UserDetailsViewController") as! UserDetailsViewController
        userDetailsVC.user = viewModel.users[indexPath.row]
        navigationController?.pushViewController(userDetailsVC, animated: true)
    }
    
}
