//
//  CategoryViewController.swift
//  MyApp
//
//  Created by Hien Nguyen on 5/31/18.
//  Copyright © 2018 Hien Nguyen. All rights reserved.
//

import UIKit
import RealmSwift

class FavoriteViewController: BaseViewController {
    // MARK: Outlet
    @IBOutlet private(set) weak var favoritetableView: UITableView!
    // MARK: Properties
    var viewModel = FavoriteViewModel()
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = App.String.favorite
        configTableView()
        configNavigation()
        viewModel.fetchData { [weak favoritetableView] (change) in
            guard let tableView = favoritetableView else { return }
            switch change {
            case .initial:
                tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                tableView.applyChanges(deletions: deletions,
                                       insertions: insertions,
                                       updates: modifications)
            case .error: break
            }
        }
    }

    func configTableView() {
        favoritetableView.dataSource = self
        favoritetableView.delegate = self
        favoritetableView.register(FavoriteVenueCell.self)
    }

    func configNavigation() {
        let clearButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clearAllItem))
        self.navigationItem.rightBarButtonItem = clearButton
    }

    @objc func clearAllItem() {
        viewModel.deleteAllItem()
    }
}
extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfvenues()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(FavoriteVenueCell.self)
        cell.updateView(venue: viewModel.viewModelItem(at: indexPath))
        return cell
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            guard let id = viewModel.viewModelItem(at: indexPath).item.id else { return }
            viewModel.deleteOneItem(id: id)
        default: break
        }
    }
}
 extension FavoriteViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        guard let id = viewModel.viewModelItem(at: indexPath).item.id else { return }
        detailVC.detailViewModel.idVenue = id
        print(id)
        navigationController?.pushViewController(detailVC, animated: true)

    }
}
