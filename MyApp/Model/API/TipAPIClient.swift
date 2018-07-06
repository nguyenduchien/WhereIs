//
//  TipAPIClient.swift
//  MyApp
//
//  Created by Hien Nguyen on 6/20/18.
//  Copyright © 2018 Hien Nguyen. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - FourSquare Tips API Client
struct TipAPIClient {
    private init() { }
    static let manager = TipAPIClient()
    func getVenueTips(venueID: String,
                      limit: Int = 20,
                      offset: Int = 1,
                      completion: @escaping ([TipObject]) -> Void) {
        let tipUrl = "https://api.foursquare.com/v2/venues/\(venueID)/tips?\(FourSquareAPIKeys.fourSquareAuthorizationToken)&limit=\(limit)&offset=\(offset)"
        Alamofire.request(tipUrl).responseJSON { (response) in
            DispatchQueue.main.async {
                if response.result.isSuccess {
                    if let data = response.data {
                        do {
                            let JSON = try JSONDecoder().decode(FourSquareTipObjectsJSON.self, from: data)
                            let tipObjects = JSON.response.tips.items //Objects
                            completion(tipObjects)
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
}
