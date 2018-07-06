//
//  FavoriteModelCell.swift
//  MyApp
//
//  Created by Hien Nguyen on 6/22/18.
//  Copyright © 2018 Hien Nguyen. All rights reserved.
//

import Foundation

struct Favorite {
    var id: String?
    var name: String?
    var address: String?
    var photoUrl: String = ""
    var rating: Double  = 0
    var likes: Int  = 0
}

final class VenueFavoriteCell {

    var item = VenueFavorite()

    init(item: VenueFavorite) {
        self.item = item
    }
}
