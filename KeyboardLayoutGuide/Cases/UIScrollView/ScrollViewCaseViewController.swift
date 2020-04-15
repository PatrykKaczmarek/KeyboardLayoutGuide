//
//  ScrollViewCaseViewController.swift
//  KeyboardLayoutGuide
//
//  Created by Patryk Kaczmarek on 03/01/2020.
//  Copyright © 2020 Patryk Kaczmarek. All rights reserved.
//

import UIKit

final class ScrollViewCaseViewController: ViewController<ScrollViewCaseView> {
    
    init() {
        super.init(view: ScrollViewCaseView())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.nameTextField.delegate = self
        customView.goButton.addTarget(self, action: #selector(goButtonWereTapped), for: .touchUpInside)
        automaticallyAdjustKeyboardLayoutGuide = true
    }
    
    @objc private func goButtonWereTapped() {
        scroll()
    }
}

extension ScrollViewCaseViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        scroll()
        view.endEditing(true)
        return true
    }
}

private extension ScrollViewCaseViewController {
    
    func scroll() {
        if let text = customView.nameTextField.text, let position = Int(text) {
            customView.scroll(to: position)
        }
    }
}
