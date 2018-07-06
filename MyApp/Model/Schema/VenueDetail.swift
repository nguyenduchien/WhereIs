//
//  VenueDetail.swift
//  MyApp
//
//  Created by Hien Nguyen on 6/26/18.
//  Copyright © 2018 Hien Nguyen. All rights reserved.
//

import Foundation
import ObjectMapper

final class VenueDetail: Mappable {
    var id: String = ""
    var name: String = ""
    var thumbnails: [String] = []
    var lat: Double = 0
    var long: Double = 0
    var address: String?
    var crossStreet: String?
    var likeCount: Int = 0
    var isFavorite: Bool = false
    var ratingPoint: Double = 0
    var feedBacks: [Feedback] = []
    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        id <- map["response.venue.id"]
        name <- map["response.venue.name"]
        lat <- map["response.venue.location.lat"]
        long <- map["response.venue.location.lng"]
        address <- map["response.venue.location.address"]
        crossStreet <- map["response.venue.location.crossStreet"]
        likeCount <- map["response.venue.likes.count"]
        ratingPoint <- map["response.venue.rating"]
    }
}
