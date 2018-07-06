//
//  CategoryCellViewModel.swift
//  MyApp
//
//  Created by Hien Nguyen on 6/12/18.
//  Copyright © 2018 Hien Nguyen. All rights reserved.
//

import Foundation

final class Category {

    var nameCategory: String
    var imageCategory: String
    var id: String

    init(nameCategory: String = "", imageCategory: String = "", id: String = "") {
        self.nameCategory = nameCategory
        self.imageCategory = imageCategory
        self.id = id
    }
}
