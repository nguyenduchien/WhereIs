//
//  Favorite.swift
//  MyApp
//
//  Created by Hien Nguyen on 6/21/18.
//  Copyright © 2018 Hien Nguyen. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class VenueFavorite: Object {

    dynamic var id: String?
    dynamic var name: String?
    dynamic var address: String?
    let likes = RealmOptional<Int>()
    let rating = RealmOptional<Double>()
    dynamic var photoUrlString: String?

    override static func primaryKey() -> String {
        return "id"
    }

    static func query(id: String) -> VenueFavorite? {
        do {
            let realm = try Realm()
            return realm.object(ofType: VenueFavorite.self, forPrimaryKey: id)
        } catch {
            print(error)
        }
        return nil
    }
}

extension VenueFavorite {

    func clean() {
        do {
            let realm = try Realm()
            let object = realm.objects(VenueFavorite.self)
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print(error)
        }
    }
}
