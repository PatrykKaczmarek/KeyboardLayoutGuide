//
//  ScrollViewCaseView.swift
//  KeyboardLayoutGuide
//
//  Created by Patryk Kaczmarek on 03/01/2020.
//  Copyright © 2020 Patryk Kaczmarek. All rights reserved.
//

import UIKit

final class ScrollViewCaseView: View {
    
    // MARK: Properties
    
    lazy var nameTextField: UITextField = {
        let textField = InsetsTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .numberPad
        textField.placeholder = "position (cm)"
        return textField
    }()
    
    lazy var goButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.blue.cgColor
        button.setTitle("find", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .white
        return button
    }()
    
    private lazy var rulerView: RulerView = {
        let view = RulerView(length: 600, divider: 10)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var scrollView: ScrollView = {
        let view = ScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: Overrides
    
    override init() {
        super.init()
        
        backgroundColor = .white
        addSubview(scrollView)
        scrollView.contentView.addSubview(nameTextField)
        scrollView.contentView.addSubview(goButton)
        scrollView.contentView.addSubview(rulerView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: keyboardLayoutGuideBackport.topAnchor),
            
            goButton.trailingAnchor.constraint(equalTo: scrollView.contentView.trailingAnchor, constant: -20),
            goButton.centerYAnchor.constraint(equalTo: nameTextField.centerYAnchor),
            goButton.widthAnchor.constraint(equalToConstant: 80),
            goButton.heightAnchor.constraint(equalToConstant: 44),
            
            nameTextField.leadingAnchor.constraint(equalTo: scrollView.contentView.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: goButton.leadingAnchor, constant: -20),
            nameTextField.topAnchor.constraint(equalTo: scrollView.contentView.topAnchor, constant: 20),
            nameTextField.heightAnchor.constraint(equalToConstant: 44),
            
            rulerView.leadingAnchor.constraint(equalTo: scrollView.contentView.leadingAnchor),
            rulerView.trailingAnchor.constraint(equalTo: scrollView.contentView.trailingAnchor),
            rulerView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            rulerView.bottomAnchor.constraint(equalTo: scrollView.contentView.bottomAnchor)
        ])
    }
    
    // MARK: API
    
    func scroll(to position: Int) {
        let partIndex = position / rulerView.divider
        let value = max(min(rulerView.length, position), 0)
        let y = rulerView.frame.minY + CGFloat(value / rulerView.divider) * rulerView.partHeight
        let maxY = scrollView.contentSize.height - scrollView.bounds.height
        scrollView.setContentOffset(CGPoint(x: 0, y: min(y, maxY)), animated: true)
        rulerView.highlightPart(at: partIndex)
    }
}
