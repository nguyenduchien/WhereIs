//
//  Location.swift
//  MyApp
//
//  Created by Hien Nguyen on 6/1/18.
//  Copyright © 2018 Hien Nguyen. All rights reserved.
//

import Foundation

struct Location {
    let coordinate: Coordinate?
    let distance: Double?
    let address: String?
    let crossStreet: String?

    init?(locationDict: [String: Any]) {
        if let latitude = locationDict["lat"] as? Double,
            let longitude = locationDict["lng"] as? Double {
            self.coordinate = Coordinate(latitude: latitude, longitude: longitude)
        } else {
            self.coordinate = nil
        }
        self.distance = locationDict["distance"] as? Double
        self.address =  locationDict["address"] as? String
        self.crossStreet = locationDict["crossStreet"] as? String
    }
}
