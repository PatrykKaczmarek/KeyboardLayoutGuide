//
//  TableViewCaseView.swift
//  KeyboardLayoutGuide
//
//  Created by Patryk Kaczmarek on 03/01/2020.
//  Copyright © 2020 Patryk Kaczmarek. All rights reserved.
//

import UIKit

final class TableViewCaseView: View {
    
    // MARK: Properties
    
    lazy var searchField: UITextField = {
        let textField = InsetsTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Search"
        return textField
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: Overrides
    
    override init() {
        super.init()
        
        backgroundColor = .white
        addSubview(searchField)
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            searchField.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchField.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            searchField.heightAnchor.constraint(equalToConstant: 44),
            
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: searchField.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: keyboardLayoutGuide.topAnchor)
        ])
    }
}
