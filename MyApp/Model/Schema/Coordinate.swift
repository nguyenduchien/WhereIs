//
//  Coordinate.swift
//  MyApp
//
//  Created by Hien Nguyen on 6/1/18.
//  Copyright © 2018 Hien Nguyen. All rights reserved.
//

import Foundation

struct Coordinate: CustomStringConvertible {
    let latitude: Double
    let longitude: Double
    var description: String {
        return "\(latitude),\(longitude)"
    }
}
