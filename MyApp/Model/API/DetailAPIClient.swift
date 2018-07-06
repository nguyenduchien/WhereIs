//
//  DetailAPIClient.swift
//  MyApp
//
//  Created by Hien Nguyen on 6/21/18.
//  Copyright © 2018 Hien Nguyen. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

final class DetailAPIClient {
    private init() { }
    static let shared = DetailAPIClient()
    func getInfo(venueID: String, completion: @escaping (Result<VenueDetail>) -> Void) {
        let detailURL = "https://api.foursquare.com/v2/venues/\(venueID)?\(FourSquareAPIKeys.fourSquareAuthorizationToken)"
        api.request(method: .get, urlString: detailURL) { result in
            Mapper<VenueDetail>().mapObj(result: result, completion: { (result) in
                DispatchQueue.main.async {
                    completion(result)
                }
            })
        }
    }
}
