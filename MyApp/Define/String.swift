//
//  Strings.swift
//  MyApp
//
//  Created by iOSTeam on 2/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

/**
 This file defines all localizable strings which are used in this application.
 Please localize defined strings in `Resources/Localizable.strings`.
 */

import Foundation
import SwiftUtils

extension App {
    struct String {
        static let error = "ERROR".localized()
        static let ok = "OK".localized()
        static let home = "Home"
        static let search = "Search"
        static let favorite = "Favorite"
        static let category = "Category"
        static let detail = "Detail Place"
        static let setting = "Setting"
        static let searchplaceholder = "Search for Venue"
    }
}

extension App.String {
    struct Key {
        static let radius = "radius"
        static let limit = "limit"
        static let near = "near"
    }
}
