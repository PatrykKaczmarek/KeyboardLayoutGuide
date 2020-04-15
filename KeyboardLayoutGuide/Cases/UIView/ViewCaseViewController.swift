//
//  ViewCaseViewController.swift
//  KeyboardLayoutGuide
//
//  Created by Patryk Kaczmarek on 20/12/2019.
//  Copyright © 2020 Patryk Kaczmarek. All rights reserved.
//

import UIKit

final class ViewCaseViewController: ViewController<ViewCaseView> {
    
    // MARK: Initializer
    
    init() {
        super.init(view: ViewCaseView())
    }
    
    // MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.emailTextField.delegate = self
        customView.passwordTextField.delegate = self
        automaticallyAdjustKeyboardLayoutGuide = true
    }
}

// MARK: UITextFieldDelegate

extension ViewCaseViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
