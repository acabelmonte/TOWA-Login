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
    var allowAutoRotate = false
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Resign responder when tapped outside the textfields
        view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))))
        
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
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if allowAutoRotate {
            return .all
        }
        else {
            return .portrait
        }
    }
    
    // MARK: - UI methods
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
