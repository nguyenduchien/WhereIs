//
//  SettingViewModel.swift
//  MyApp
//
//  Created by Hien Nguyen on 7/3/18.
//  Copyright © 2018 Hien Nguyen. All rights reserved.
//

import Foundation

final class SettingViewModel {

    var limits: String? {
        return userDefault.string(forKey: App.String.Key.limit)
    }

    var radius: String? {
        return userDefault.string(forKey: App.String.Key.radius)
    }
    var near: String? {
        return userDefault.string(forKey: App.String.Key.near)
    }
}
