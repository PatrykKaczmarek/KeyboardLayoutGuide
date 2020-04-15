//
//  ViewController.swift
//  KeyboardLayoutGuide
//
//  Created by Patryk Kaczmarek on 19/12/2019.
//  Copyright © 2020 Patryk Kaczmarek. All rights reserved.
//

import UIKit

class ViewController<CustomView: View>: UIViewController {

    // MARK: Properties

    /// Flag indicating whether top keyboard layout guide should be tracked.
    /// It is recommended to set this flag in view controller's init method
    /// cause keyboard may appear before the view controller's view is fully loaded.
    ///
    /// Setting this property to `true` automatically registers view controller for keyboard notifications.
    /// Setting this property to `false` automatically removes view controller from keyboard notifications.
    ///
    /// Example:
    /// Few view controllers have been initialized at once but only one of them has been displayed.
    /// It means that only this one which is visible, loaded its view.
    /// Other view controllers will load their views (technically invoke viewDidLoad() method)
    /// shortly before they become visible.
    ///
    /// - SeeAlso: View.keyboardHeightConstraint
    /// - SeeAlso: View.KeyboardLayoutGuide
    /// - SeeAlso: UIViewController.isViewLoaded
    ///
    /// - Warning: Switching to emoji keyboard by pressing the language selector button (the globe) works fine.
    ///            Neverthelss when changing keyboard type by long pressing the language selector button,
    ///            no UIKeyboardWillChangeFrame notification is sent what causes layout guide to not be adjusted properly.
    ///            It looks as a bug on iOS 11, since even the apple messages and facebook messenger apps don't handle this right.
    var automaticallyAdjustKeyboardLayoutGuide = false {
        willSet {
            newValue ? registerForKeyboardNotifications() : stopObservingKeyboardNotifications()
        }
    }

    /// Closure triggered when keyboard is going to appear.
    var onKeyboardWillAppear: ((Notification) -> Void)?

    /// Closure triggered when keyboard is going to disappear.
    var onKeyboardWillDisappear: ((Notification) -> Void)?

    /// Custom View
    let customView: CustomView

    // MARK: Initializer

    /// Initializes view controller with generic `View`.
    ///
    /// - Parameters:
    ///   - view: A main view of view controller that will be placed on top of view controller's view.
    init(view: CustomView) {
        customView = view
        customView.translatesAutoresizingMaskIntoConstraints = false
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// - SeeAlso: Swift.deinit
    deinit {
        stopObservingKeyboardNotifications()
    }

    // MARK: Overrides

    /// - SeeAlso: UIViewController.loadView()
    override func loadView() {
        super.loadView()

        view.addSubview(customView)
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: view.topAnchor),
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: Private

private extension ViewController {

    func registerForKeyboardNotifications() {
        let center = NotificationCenter.default
        center.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { [weak self] notification in
            guard let self = self else {
                return
            }
            if self.automaticallyAdjustKeyboardLayoutGuide {
                let offset = notification.keyboardRect?.height ?? 0
                let animationDuration = notification.keyboardAnimationDuration ?? 0.25
                self.adjustKeyboardHeightConstraint(byOffset: offset, animationDuration: animationDuration)
            }
            self.onKeyboardWillAppear?(notification)
        }
        center.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { [weak self] notification in
            guard let self = self else {
                return
            }
            if self.automaticallyAdjustKeyboardLayoutGuide {
                let animationDuration = notification.keyboardAnimationDuration ?? 0.25
                self.adjustKeyboardHeightConstraint(byOffset: 0, animationDuration: animationDuration)
            }
            self.onKeyboardWillDisappear?(notification)
        }
        center.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification, object: nil, queue: nil) { [weak self] notification in
            guard let self = self else {
                return
            }
            if self.automaticallyAdjustKeyboardLayoutGuide, let offset = notification.keyboardRect?.height {
                let animationDuration = notification.keyboardAnimationDuration ?? 0.25
                self.adjustKeyboardHeightConstraint(byOffset: offset, animationDuration: animationDuration)
            }
        }
    }

    func stopObservingKeyboardNotifications() {
        [
            UIResponder.keyboardWillHideNotification,
            UIResponder.keyboardWillShowNotification,
            UIResponder.keyboardWillChangeFrameNotification
        ].forEach {
            NotificationCenter.default.removeObserver(self, name: $0, object: nil)
        }
    }

    func adjustKeyboardHeightConstraint(byOffset offset: CGFloat, animationDuration: TimeInterval) {
        customView.keyboardHeightConstraint.constant = offset
        UIView.animate(withDuration: animationDuration) {
            self.customView.layoutIfNeeded()
        }
    }
}

// MARK: Notification

private extension Notification {

    /// Defines the duration of keyboard animation.
    /// Nil if notification doesn't contain such info.
    var keyboardAnimationDuration: TimeInterval? {
        (userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
    }

    /// Defines the rectangle of keyboard.
    /// Nil if notification doesn't contain such info.
    var keyboardRect: CGRect? {
        userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
    }
}
