//
//  RulerView.swift
//  KeyboardLayoutGuide
//
//  Created by Patryk Kaczmarek on 02/04/2020.
//  Copyright © 2020 Patryk Kaczmarek. All rights reserved.
//

import UIKit

final class RulerView: UIView {
    
    // MARK: Properties
    
    let length: Int
    
    let divider: Int
    
    var partHeight: CGFloat {
        frame.height * CGFloat(divider) / CGFloat(length)
    }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    // MARK: Initializer
    
    init(length: Int, divider: Int) {
        self.length = length
        self.divider = divider
        super.init(frame: .zero)
        
        backgroundColor = .yellow
        addSubview(stackView)
        (0...(length / divider)).forEach { i in
            let arrangedSubview = RulerPart(
                text: "\(i * divider) cm",
                isFirst: i == 0,
                isLast: i * divider == length
            )
            stackView.addArrangedSubview(arrangedSubview)
        }
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    @available(*, unavailable, message: "Use init(length:divider:) method instead.")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: API
    
    func highlightPart(at index: Int) {
        stackView.arrangedSubviews.enumerated().forEach { subviewIndex, arrangedSubview in
            (arrangedSubview as? RulerPart)?.isHighlighted = index == subviewIndex
        }
    }
}
