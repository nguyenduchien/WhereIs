//
//  PhotoAPIClient.swift
//  MyApp
//
//  Created by Hien Nguyen on 6/14/18.
//  Copyright © 2018 Hien Nguyen. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - FourSquare Photo API Client
struct PhotoAPIClient {
    private init() { }
    static let manager = PhotoAPIClient()
    func getVenuePhotos(venueID: String, completion: @escaping ([PhotoObject]) -> Void) {
        let photoUrl = "https://api.foursquare.com/v2/venues/\(venueID)/photos?\(FourSquareAPIKeys.fourSquareAuthorizationToken)&limit=20"
        Alamofire.request(photoUrl).responseJSON { (response) in
            if response.result.isSuccess {
                if let data = response.data {
                    do {
                        let JSON = try JSONDecoder().decode(FourSquarePhotoObjectsJSON.self, from: data)
//                        let numOfPhotoObjects = JSON.response.photos.count
                        let photoObjects = JSON.response.photos.items //Objects
                        completion(photoObjects)
                    } catch {
                        print("Error processing data \(error)")
                    }
                }
            } else {
                print("Error\(String(describing: response.result.error))")
            }
        }
    }
}
