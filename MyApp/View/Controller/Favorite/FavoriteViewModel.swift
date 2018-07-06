//
//  FavoriteViewModel.swift
//  MyApp
//
//  Created by Hien Nguyen on 6/21/18.
//  Copyright © 2018 Hien Nguyen. All rights reserved.
//

import Foundation
import RealmSwift

final class FavoriteViewModel {

    // MARK: - Properties
    private var itemToken: NotificationToken?
    private var items: Results<VenueFavorite>?
    private let venueFavorite = VenueFavorite()
    typealias Completion = (RealmCollectionChange<Results<VenueFavorite>>) -> Void
    var imgThumbnailUrl: String?

    func venueIsEmpty() -> Bool {
        guard let items = items else { return true }
        return items.isEmpty
    }

    func deleteVenueItem() {
        venueFavorite.clean()
    }

    func numberOfvenues() -> Int {
        guard let items = items else { return 0 }
        return items.count
    }

    func viewModelItem(at indexPath: IndexPath) -> VenueFavoriteCell {
        guard let items = items?[indexPath.row] else { fatalError("") }
        return VenueFavoriteCell(item: items)
    }

    func deleteOneItem(id: String) {
        do {
            let realm = try Realm()
            guard let item = realm.object(ofType: VenueFavorite.self, forPrimaryKey: id) else { return }
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print(error)
        }
    }

    func deleteAllItem() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print(error)
        }
    }

    func fetchData(completion: @escaping Completion) {
        do {
            let realm = try Realm()
            let item = realm.objects(VenueFavorite.self)
            itemToken = item.observe({ [weak self] change in
                guard let this = self else { return }
                this.items = item
                completion(change)
            })
        } catch {
            print(error)
        }
    }

    func fetchImagesData(id: String, completion: @escaping (String) -> Void) {
        PhotoAPIClient.manager.getVenuePhotos(venueID: id) { (result) in
            if !result.isEmpty {
                guard let item = result.first else { return }
                completion(item.prefix + "200x200" + item.suffix)
            }
        }
    }
}

extension FavoriteViewModel {

    enum Result {
        case success
        case failure(error: AppError)
    }
}
