//
//  CategoryViewController.swift
//  MyApp
//
//  Created by Hien Nguyen on 5/31/18.
//  Copyright © 2018 Hien Nguyen. All rights reserved.
//

import UIKit
protocol CategoryViewControllerDelegate: class {
    func viewController(_ viewController: CategoryViewController, needsPerformAction action: CategoryViewController.Action)
}
final class CategoryViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet private(set) weak var categorytableView: UITableView!
    var viewModel = CategoryViewModel()

    weak var delegate: CategoryViewControllerDelegate?

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = App.String.category
        configTableView()
    }

    func configTableView() {
        categorytableView.register(ListCategoryCell.self)
        categorytableView.rowHeight = Config.rowHeight
        categorytableView.dataSource = self
        categorytableView.delegate = self
    }
}
// MARK: - UITableViewDelegate
extension CategoryViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRow()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(ListCategoryCell.self)
        cell.viewModel = viewModel.viewModelForCell(at: indexPath)
        return cell
    }
}
// MARK: - UITableViewDelegate
extension CategoryViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
       // recive indexpath to implement func deletaget and return date to home
        let id = viewModel.category(at: indexPath).id
        delegate?.viewController(self, needsPerformAction: .filter(id))
        self.navigationController?.popViewController(animated: true)
    }
}
// MARK: - Defineinit
extension CategoryViewController {

    enum Action {
        case filter(String)
    }

    struct Config {
        static let rowHeight: CGFloat = 80
    }
}
