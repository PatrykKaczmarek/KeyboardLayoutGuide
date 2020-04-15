//
//  InsetsTextField.swift
//  KeyboardLayoutGuide
//
//  Created by Patryk Kaczmarek on 03/01/2020.
//  Copyright © 2020 Patryk Kaczmarek. All rights reserved.
//

import UIKit

final class InsetsTextField: UITextField {

    let insets: UIEdgeInsets

    init(insets: UIEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)) {
        self.insets = insets
        super.init(frame: .zero)
    }

    @available(*, unavailable, message: "Use init(insets:) method instead.")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func placeholderRect(forBounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
}
