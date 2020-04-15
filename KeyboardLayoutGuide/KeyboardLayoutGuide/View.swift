//
//  View.swift
//  KeyboardLayoutGuide
//
//  Created by Patryk Kaczmarek on 19/12/2019.
//  Copyright © 2020 Patryk Kaczmarek. All rights reserved.
//

import UIKit

class View: UIView {

    // MARK: Properties

    /// A constraint representing height of the keyboard.
    /// Automatically handled by ViewController when
    /// automaticallyAdjustKeyboardLayoutGuide is set to true.
    ///
    /// - SeeAlso: View.keyboardLayoutGuide
    /// - SeeAlso: ViewController.automaticallyAdjustKeyboardLayoutGuide
    private(set) lazy var keyboardHeightConstraint = keyboardLayoutGuide.heightAnchor.constraint(equalToConstant: 0)

    /// Layout guide representing top of the keyboard.
    /// Equal to bottom layout guide of view when keyboard is not visible.
    /// This guide changes its position with animation on keyboard transition
    /// only when ViewController.automaticallyAdjustKeyboardLayoutGuide is set to true.
    ///
    /// - SeeAlso: View.keyboardHeightConstraint
    /// - SeeAlso: ViewController.automaticallyAdjustKeyboardLayoutGuide
    let keyboardLayoutGuide = UILayoutGuide()
    
    // MARK: Initializer

    /// Initializes view for auto layout and sets default `.white` background color.
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white

        addLayoutGuide(keyboardLayoutGuide)
        NSLayoutConstraint.activate([
            keyboardHeightConstraint,
            keyboardLayoutGuide.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    @available(*, unavailable, message: "Use init() method instead.")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Overrides

    /// - SeeAlso: UIView.requiresConstraintBasedLayout
    override static var requiresConstraintBasedLayout: Bool {
        true
    }
}

class DemoView: UIView {
    
    let KeyboardLayoutGuide = UILayoutGuide()
    
    private(set) var keyboardHeightConstraint: NSLayoutConstraint?
    
    init() {
        super.init(frame: .zero)

        addLayoutGuide(KeyboardLayoutGuide)
        let keyboardHeightConstraint = KeyboardLayoutGuide.heightAnchor.constraint(equalToConstant: 0)
        NSLayoutConstraint.activate([
            keyboardHeightConstraint,
            KeyboardLayoutGuide.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        self.keyboardHeightConstraint = keyboardHeightConstraint
    }
    
    /// more methods
    
    @available(*, unavailable, message: "Use init() method instead.")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
