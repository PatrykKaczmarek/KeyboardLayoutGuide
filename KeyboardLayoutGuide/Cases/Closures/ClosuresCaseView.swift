//
//  ClosuresCaseView.swift
//  KeyboardLayoutGuide
//
//  Created by Patryk Kaczmarek on 03/01/2020.
//  Copyright © 2020 Patryk Kaczmarek. All rights reserved.
//

import UIKit

final class ClosuresCaseView: View {
    
    // MARK: Properties
    
    lazy var textField: UITextField = {
        let textField = InsetsTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Tap me!"
        return textField
    }()
    
    // MARK: Overrides
    
    override init() {
        super.init()
        
        backgroundColor = .white
        addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            textField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            textField.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
}
