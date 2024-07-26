//
//  DemoTableViewController.swift
//  KeyboardLayoutGuide
//
//  Created by Patryk Kaczmarek on 20/12/2019.
//  Copyright © 2020 Patryk Kaczmarek. All rights reserved.
//

import UIKit

final class DemoTableViewController: UITableViewController {

    enum Kind: Int, CaseIterable {
        case view = 0, scrollView, tableView, closures
    }

    // MARK: Properties

    private let tableViewCellIdentifier = "\(String(describing: DemoTableViewController.self)).cellIdentifier"

    // MARK: Initalizer

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Overrides

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Demo"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: tableViewCellIdentifier)
    }

    /// - SeeAlso: UITableViewDataSource.tableView(_:numberOfRowsInSection:)
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Kind.allCases.count
    }

    /// - SeeAlso: UITableViewDataSource.tableView(_:cellForRowAt:)
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath)
        cell.textLabel?.text = Kind.allCases[indexPath.row].title
        return cell
    }

    // MARK: UITableViewDelegate

    /// - SeeAlso: UITableViewDelegate.tableView(_:didSelectRowAt:)
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        show(Kind.allCases[indexPath.row].viewControllerToPush, sender: nil)
    }
}

private extension DemoTableViewController.Kind {

    var title: String {
        switch self {
        case .view:
            return "UIView case"
        case .scrollView:
            return "UIScrollView case"
        case .tableView:
            return "UITableView case"
        case .closures:
            return "Closures case"
        }
    }

    var viewControllerToPush: UIViewController {
        switch self {
        case .view:
            return ViewCaseViewController()
        case .scrollView:
            return ScrollViewCaseViewController()
        case .tableView:
            return TableViewCaseViewController()
        case .closures:
            return ClosuresCaseViewController()
        }
    }
}
