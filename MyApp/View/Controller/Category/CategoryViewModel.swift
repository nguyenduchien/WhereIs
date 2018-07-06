//
//  Category.swift
//  MyApp
//
//  Created by Hien Nguyen on 6/8/18.
//  Copyright © 2018 Hien Nguyen. All rights reserved.
//

import Foundation

typealias Json = [String: Any]

final class CategoryViewModel {

    // MARK: - Properties
    var categories: [MyCategory] = {
        return MyCategory.initData()
    }()

    var images: [String]  = ["ic_category_grocery",
                             "ic_category_coffee",
                             "ic_category_nightlife",
                             "ic_category_food",
                             "ic_category_gasstation",
                             "ic_category_atm",
                             "ic_category_pharmacy"]

}

extension CategoryViewModel {

    func category(at indexPath: IndexPath) -> MyCategory {
        return categories[indexPath.row]
    }
}

extension CategoryViewModel {

    func numberOfRow() -> Int {
        return categories.count
    }

    func viewModelForCell(at indexPath: IndexPath) -> ListCategoryCellViewModel? {
        let name = categories[indexPath.row].name
        let id = categories[indexPath.row].id
        let image = images[indexPath.row]
        let category = Category(nameCategory: name, imageCategory: image, id: id)
        let viewModel = ListCategoryCellViewModel(category: category)
        return viewModel
    }
}

extension CategoryViewModel {

    struct MyCategory {
        var name: String
        var id: String
        var image: String?
        static func initData() -> [MyCategory] {
            if let path = Bundle.main.url(forResource: "CategoryVenue", withExtension: "plist"),
                let data = NSDictionary(contentsOf: path) as? Json {
                return data.compactMap { (arg) -> MyCategory in
                    return MyCategory(name: arg.key, id: "\(arg.value)", image: nil)
                }
            }
            return []
        }
    }
}
