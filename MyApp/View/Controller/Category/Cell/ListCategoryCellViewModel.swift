//
//  ListCategoryCellViewModel.swift
//  MyApp
//
//  Created by Hien Nguyen on 7/3/18.
//  Copyright © 2018 Hien Nguyen. All rights reserved.
//

import Foundation

final class ListCategoryCellViewModel {

    private let category: Category

    init(category: Category = Category()) {
        self.category = category
    }
}

extension ListCategoryCellViewModel {
    var name: String {
        return category.nameCategory
    }

    var imagePath: String {
        return category.imageCategory
    }
}
