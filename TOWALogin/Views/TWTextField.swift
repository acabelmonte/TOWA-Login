//
//  TWTextField.swift
//  TOWA Login
//
//  Created by Arthur Christopher Belmonte on 7/9/22.
//

import UIKit

class TWTextField: UIView {
    
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var bottomLine: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var passwordImageView: UIImageView!
    @IBOutlet private weak var labelOffsetConstraint: NSLayoutConstraint!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var textField: UITextField!
    
    private let hidePasswordImage = UIImage(named: "hide-password")
    private let showPasswordImage = UIImage(named: "show-password")
    private var showPassword = false
    
    // MARK: - Custom getter/setter
    private var _isSecureText = false
    var isSecureText: Bool {
        get {
            return _isSecureText
        }
        set {
            _isSecureText = newValue
            if newValue == true {
                textField.isSecureTextEntry = true
                imageView.image = UIImage(named: "password")
                passwordImageView.image = hidePasswordImage
            }
            else {
                textField.isSecureTextEntry = false
                imageView.image = UIImage(named: "username")
                passwordImageView.image = nil
            }
        }
    }
    
    private var _title = ""
    var title: String {
        get {
            return _title
        }
        set {
            titleLabel.text = newValue
        }
    }
    
    private var _text = ""
    var text: String {
        get {
            return textField.text ?? ""
        }
        set {
            textField.text = newValue
            
            // Reset textfield state
            if newValue == "" {
                moveDownTitleLabel()
                
                if isSecureText {
                    passwordImageView.image = hidePasswordImage
                    textField.isSecureTextEntry = true
                }
            }
        }
    }
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        Bundle.main.loadNibNamed("TWTextField", owner: self)
        addSubview(contentView)
        contentView.frame = self.bounds
        bottomLine.isHidden = false
        layer.shadowColor = UIColor.clear.cgColor
    }
    
    // MARK: - Button methods
    @IBAction func textFieldButtonTapped(_ sender: Any) {
        moveUpTitleLabel()
        textField.becomeFirstResponder()
    }
    
    @IBAction func showPasswordButtonTapped(_ sender: Any) {
        passwordImageView.image = (showPassword) ? hidePasswordImage : showPasswordImage
        textField.isSecureTextEntry = showPassword
        showPassword = !showPassword
    }
    
    // MARK: - UI methods
    private func moveUpTitleLabel() {
        labelOffsetConstraint.priority = .defaultLow
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    private func moveDownTitleLabel() {
        labelOffsetConstraint.priority = .defaultHigh
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    private func showSelected() {
        UIView.animate(withDuration: 0.3) {
            self.layer.shadowColor = UIColor.darkGray.cgColor
            self.bottomLine.isHidden = true
        }
    }
    
    private func hideSelected() {
        UIView.animate(withDuration: 0.3) {
            self.layer.shadowColor = UIColor.clear.cgColor
            self.bottomLine.isHidden = false
        }
    }
    
}

// MARK: - UITextFieldDelegate
extension TWTextField: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        showSelected()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, text.count == 0 {
            self.moveDownTitleLabel()
        }
        
        hideSelected()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
}
