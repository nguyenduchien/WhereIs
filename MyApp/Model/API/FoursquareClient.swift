//
//  FoursquareClient.swift
//  MyApp
//
//  Created by Hien Nguyen on 6/1/18.
//  Copyright © 2018 Hien Nguyen. All rights reserved.
//

import Foundation
  class FoursquareClient {
    // MARK: Properties
    let clientId: String
    let clientSecret: String
    let oauthToken: String
    init(clientId: String, clientSecret: String, oauthToken: String) {
        self.clientId = clientId
        self.clientSecret = clientSecret
        self.oauthToken = oauthToken
    }
    // MARK: CONNECT API, PARSE JSON
    func fetchVenuesFor(coordinate: Coordinate,
                        query: String? = nil,
                        categoryId: String? = nil,
                        searchRadius: Int? = nil,
                        limit: Int? = nil,
                        near: String? = nil,
                        completion: @escaping (APIResult<[Venue]>) -> Void) {
        let searchEndpoint = FoursquareEndpoint.search(clientId: self.clientId,
                                                       clientSecret: self.clientSecret,
                                                       oauthToken: self.oauthToken,
                                                       coordinate: coordinate,
                                                       categoryId: categoryId,
                                                       query: query,
                                                       searchRadius: searchRadius,
                                                       limit: limit,
                                                       near: near)
        guard let request = searchEndpoint.request else { return }
        let networkProcessing = NetworkProcessing(request: request)
        networkProcessing.downloadJSON { (json, _, error) in
            // (1) Get back on Main Thread
            DispatchQueue.main.async {
                // (2) Turn JSON in [Venue]
                guard let json = json else {
                    if let err = error {
                        completion(.failure(err))
                    }
                    return
                }
                guard let response = json["response"] as? [String: Any], let venueDictionaries = response["venues"] as? [[String: Any]] else {
                let error = NSError(domain: DANetworkingErrorDomain, code: unexpectedResponseError, userInfo: nil)
                    completion(.failure(error))
                    return
                }
                // (3) Call Completion
                let venues = venueDictionaries.compactMap { venueDict in
                    return Venue(venueDict: venueDict)
                }
                completion(.success(venues))
            }
        }
    }

    func fetchData(url: URL, completion: @escaping (APIResult<Data>) -> Void) {
        let request = URLRequest(url: url)
        let networkProcessing = NetworkProcessing.init(request: request)
        networkProcessing.downloadData { (data, _, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                } else if let data = data {
                    completion(.success(data))
                }
            }
        }
    }
}
