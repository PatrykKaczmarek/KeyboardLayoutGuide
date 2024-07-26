//
//  ViewCaseView.swift
//  KeyboardLayoutGuide
//
//  Created by Patryk Kaczmarek on 20/12/2019.
//  Copyright © 2020 Patryk Kaczmarek. All rights reserved.
//

import UIKit

final class ViewCaseView: View {
    
    // MARK: Properites
    
    lazy var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = InsetsTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Email"
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = InsetsTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        return textField
    }()
    
    // MARK: Overrides
    
    override init() {
        super.init()
        
        addSubview(signInButton)
        addSubview(passwordTextField)
        addSubview(emailTextField)
        
        NSLayoutConstraint.activate([
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            emailTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            emailTextField.heightAnchor.constraint(equalToConstant: 44),
            
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 40),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44),
            
            signInButton.heightAnchor.constraint(equalToConstant: 44),
            signInButton.widthAnchor.constraint(equalToConstant: 200),
            signInButton.bottomAnchor.constraint(equalTo: keyboardLayoutGuideBackport.topAnchor, constant: -40),
            signInButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
