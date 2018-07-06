//
//  Color.swift
//  MyApp
//
//  Created by iOSTeam on 2/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

/**
 This file defines all colors which are used in this application.
 Please navigate by the control as prefix.
 */

import UIKit

extension App {
    struct Color {
        static let navigationBar = UIColor.black
        static let tableHeaderView = UIColor.gray
        static let tableFooterView = UIColor.red
        static let tableCellTextLabel = (red: 0, green: 192 / 255, blue: 110 / 255, alpha: 1)
        static let barTinColor = UIColor(red: 0, green: 192 / 255, blue: 110 / 255, alpha: 1)

        static func button(state: UIControlState) -> UIColor {
            switch state {
            case UIControlState.normal: return .blue
            default: return .gray
            }
        }
        static func random() -> UIColor {
            var colors: [UIColor] = [
                UIColor(red: 245/255.0, green: 166/255.0, blue: 35/255.0, alpha: 1.0),
                UIColor(red: 144/255.0, green: 19/255.0, blue: 254/255.0, alpha: 1.0),
                UIColor(red: 249/255.0, green: 103/255.0, blue: 30/255.0, alpha: 1.0),
                UIColor(red: 35/255.0, green: 141/255.0, blue: 255/255.0, alpha: 1.0),
                UIColor(red: 255/255.0, green: 45/255.0, blue: 85/255.0, alpha: 1.0)
            ]
            let random = Int(arc4random()) % colors.count
            return colors[random]
        }
    }
}
