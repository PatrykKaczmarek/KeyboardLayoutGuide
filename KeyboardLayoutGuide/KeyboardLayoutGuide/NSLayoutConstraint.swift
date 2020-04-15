//
//  NSLayoutConstraint.swift
//  KeyboardLayoutGuide
//
//  Created by Patryk Kaczmarek on 03/01/2020.
//  Copyright © 2020 Patryk Kaczmarek. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {

    /// Sets a constraint priority.
    ///
    /// - Parameter priority: A new constraint priority.
    /// - Returns: Constraint which priority did change.
    @discardableResult
    func with(priority: UILayoutPriority) -> Self {
        self.priority = priority
        return self
    }

    /// Sets a constraint priority.
    ///
    /// - Parameter priority: A new constraint priority.
    /// - Returns: Constraint which priority did change.
    @discardableResult
    func with(priority: Float) -> Self {
        with(priority: UILayoutPriority(priority))
    }
}
