//
//  ScrollView.swift
//  KeyboardLayoutGuide
//
//  Created by Patryk Kaczmarek on 03/01/2020.
//  Copyright © 2020 Patryk Kaczmarek. All rights reserved.
//

import UIKit

/// This class embeds its own content view which nicely resolves all
/// UIScrollView scrollable content size ambiguities.
final class ScrollView: UIScrollView {

    // MARK: Properties

    /// Default superview for content displayed by the scroll view.
    /// If you want to customize scroll view by adding additional views,
    /// you should add them to the content view so they will be positioned appropriately.
    private(set) lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: Overrides

    /// - SeeAlso: UIScrollView.init(frame:)
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor).with(priority: .defaultLow),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.centerYAnchor.constraint(equalTo: centerYAnchor).with(priority: .defaultLow),
            contentView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    @available(*, unavailable, message: "Use init(frame:) method instead.")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
