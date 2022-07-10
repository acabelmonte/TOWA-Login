//
//  BaseViewController.swift
//  TOWA Login
//
//  Created by Arthur Christopher Belmonte on 7/9/22.
//

import UIKit
import Toast

class BaseViewController: UIViewController {
    
    let yellowColor = UIColor.init(red: 255/255, green: 168/255, blue: 0/255, alpha: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Resign responder when tapped outside the textfields
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        // Setup Toast style
        let style = CSToastManager.sharedStyle()
        style?.backgroundColor = yellowColor
        style?.horizontalPadding = 40.0
        style?.verticalPadding = 12.0
        style?.messageNumberOfLines = 0
        style?.shadowOpacity = 0.3
        style?.displayShadow = true
        style?.messageFont = UIFont(name:"GeezaPro-Bold", size:17)
    }
    
    func showMessage(message: String) {
        DispatchQueue.main.async {
            self.view.makeToast(message, duration: 2.0, position: CSToastPositionTop)
        }
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            self.view.makeToastActivity(CSToastPositionCenter)
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.view.hideToastActivity()
        }
    }

}