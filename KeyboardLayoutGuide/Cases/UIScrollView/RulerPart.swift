//
//  RulerPart.swift
//  KeyboardLayoutGuide
//
//  Created by Patryk Kaczmarek on 02/04/2020.
//  Copyright © 2020 Patryk Kaczmarek. All rights reserved.
//

import UIKit

final class RulerPart: UIView {
    
    // MARK: Properties
    
    var isHighlighted: Bool = false {
        didSet {
            backgroundColor = isHighlighted ? UIColor.red.withAlphaComponent(0.1) : UIColor.clear
        }
    }
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let isFirst: Bool
    
    private let isLast: Bool
    
    // MARK: Initializer
    
    init(text: String, isFirst: Bool, isLast: Bool) {
        self.isFirst = isFirst
        self.isLast = isLast
        super.init(frame: .zero)
        
        addSubview(label)
        backgroundColor = .clear
        label.text = text
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    @available(*, unavailable, message: "Use init(text:isFirst:isLast:) method instead.")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Overrides
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: 40)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        context.setStrokeColor(UIColor.black.cgColor)
        
        if !isFirst {
            context.setLineWidth(1.0)
            context.move(to: CGPoint(x: 0, y: bounds.minY))
            context.addLine(to: CGPoint(x: 10, y: bounds.minY))
        }
        
        context.setLineWidth(2.0)
        context.move(to: CGPoint(x: 0, y: bounds.midY))
        context.addLine(to: CGPoint(x: 20, y: bounds.midY))
        
        if !isLast {
            context.setLineWidth(1.0)
            context.move(to: CGPoint(x: 0, y: bounds.maxY))
            context.addLine(to: CGPoint(x: 10, y: bounds.maxY))
        }
        
        context.strokePath()
    }
}
