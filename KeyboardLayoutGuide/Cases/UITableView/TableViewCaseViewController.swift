//
//  TableViewCaseViewController.swift
//  KeyboardLayoutGuide
//
//  Created by Patryk Kaczmarek on 03/01/2020.
//  Copyright © 2020 Patryk Kaczmarek. All rights reserved.
//

import UIKit

final class TableViewCaseViewController: ViewController<TableViewCaseView> {
    
    // MARK: Private

    private let tableViewCellReuseIdentifier = "TableViewCaseViewControllerCell"

    private lazy var cars: [Car] = {
        guard let url = Bundle.main.url(forResource: "car-list", withExtension: "json") else {
            return []
        }

        do {
            let data = try Data(contentsOf: url, options: .mappedIfSafe)
            return try JSONDecoder().decode([Car].self, from: data)
        } catch {
            return []
        }
    }()

    private var filteredCars: [Car] = []
    
    private var source: [Car] {
        if let searchText = customView.searchField.text, !searchText.isEmpty {
            return filteredCars
        }
        return cars
    }
    
    // MARK: Initializer

    init() {
        super.init(view: TableViewCaseView())
    }
    
    // MARK: Overrides

    override func viewDidLoad() {
        super.viewDidLoad()

        customView.searchField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        customView.searchField.delegate = self
        customView.tableView.dataSource = self
        customView.tableView.allowsSelection = false
        customView.tableView.register(CarTableViewCell.self, forCellReuseIdentifier: tableViewCellReuseIdentifier)
        automaticallyAdjustKeyboardLayoutGuide = true
    }
}

// MARK: UITableViewDataSource

extension TableViewCaseViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        source.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellReuseIdentifier, for: indexPath)
        cell.textLabel?.text = source[indexPath.row].brand
        cell.detailTextLabel?.text = "\( source[indexPath.row].models.count) models"
        return cell
    }
}

// MARK: UITextFieldDelegate

extension TableViewCaseViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

// MARK: Private

private extension TableViewCaseViewController {

    @objc func textFieldDidChange(textField: UITextField) {
        if let string = textField.text?.lowercased() {
            filteredCars = cars.filter { $0.brand.lowercased().contains(string) }
        } else {
            filteredCars = []
        }
        customView.tableView.reloadData()
    }
}
