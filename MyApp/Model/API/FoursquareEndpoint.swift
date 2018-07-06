//
//  FoursquareEndpoint.swift
//  MyApp
//
//  Created by Hien Nguyen on 6/1/18.
//  Copyright © 2018 Hien Nguyen. All rights reserved.
//

import Foundation

enum TypeSetting {
    case limit
    case radius
    case near

    var value: String? {
        switch self {
        case .limit:
            let limit = userDefault.string(forKey: App.String.Key.limit)
            if limit == "0" {
                userDefault.set(30, forKey: App.String.Key.limit)
                return "30"
            }
            return limit
        case .radius:
            let radius = userDefault.string(forKey: App.String.Key.radius)
            if radius == "0" {
                userDefault.set(1000, forKey: App.String.Key.radius)
                return "1000"
            }
            return radius
        case .near:
            let near = userDefault.string(forKey: App.String.Key.near)
            if near == "" {
                userDefault.set("", forKey: App.String.Key.near)
                return ""
            }
            return near
        }
    }
}

final class FoursquareEndPoint {
    func getValue(type: TypeSetting) -> String? {
        return type.value
    }
}

enum FoursquareEndpoint {

    case search(clientId: String,
        clientSecret: String,
        oauthToken: String,
        coordinate: Coordinate,
        categoryId: String? ,
        query: String?,
        searchRadius: Int?,
        limit: Int?,
        near: String?)

    var baseURL: String {
        return "https://api.foursquare.com"
    }

    var path: String {
        switch self {
        case .search:
            return "/v2/venues/search"
        }
    }

    // MARK: STRUCT PARAMETER FOURSQUARE

    private struct ParameterKeys {
        static let clientId = "client_id"
        static let clientSecret = "client_secret"
        static let oauthToken = "oauth_token"
        static let version = "v"
        static let category = "categoryId"
        static let location = "ll"
        static let query = "query"
        static let limit = "limit"
        static let searchRadius = "radius"
        static let near = "near"
    }

    private struct DefaultValues {
        static let version = FourSquareAPIKeys.todaysDate
        static var searchRadius: String? {
            return FoursquareEndPoint().getValue(type: .radius)
        }
        static var limit: String? {
            return FoursquareEndPoint().getValue(type: .limit)
        }
        static var near: String? {
            return FoursquareEndPoint().getValue(type: .near)
        }

    }

    // MARK : SET PRAMETER KEY
    var parameters: [String: Any] {
        switch self {
        case .search( let clientId,
                      let clientSecret,
                      let oauthToken,
                      let coordinate,
                      let category,
                      let query,
                      let searchRadius,
                      let limit,
                      let near ):
            var parameters: [String: Any] = [
                ParameterKeys.clientId: clientId,
                ParameterKeys.clientSecret: clientSecret,
                ParameterKeys.oauthToken: oauthToken,
                ParameterKeys.version: DefaultValues.version,
                ParameterKeys.location: coordinate.description
            ]
            if let searchRadius = searchRadius {
                parameters[ParameterKeys.searchRadius] = searchRadius
            } else {
                parameters[ParameterKeys.searchRadius] = DefaultValues.searchRadius
            }
            if let limit = limit {
                parameters[ParameterKeys.limit] = limit
            } else {
                parameters[ParameterKeys.limit] = DefaultValues.limit
            }
            if let near = near {
                parameters[ParameterKeys.near] = near
            } else {
                parameters[ParameterKeys.near] = DefaultValues.near
            }
            if let query = query {
                parameters[ParameterKeys.query] = query
            }
            if let category = category {
                parameters[ParameterKeys.category] = category
            }
            return parameters
        }
    }
    // MARK: Request Query
    var queryComponents: [URLQueryItem] {
        var components: [URLQueryItem] = []
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.append(queryItem)
        }
        return components
    }
    var request: URLRequest? {
        var endpoints = URLComponents(string: baseURL)
        endpoints?.path = path
        endpoints?.queryItems = queryComponents
        guard let url = endpoints?.url else {
            return nil
        }
        return URLRequest(url: url)
    }
    //
    //    func searchEndpointWithNear(near: String, query: String) -> String {
    //        var endpoint = URLComponents(string: "https://api.foursquare.com/v2/venues/search")
    //        endpoint?.queryItems = [
    //            URLQueryItem(name: "near", value: near),
    //            URLQueryItem(name: "query", value: query)
    //        ]
    //        let venueEndpoint = endpoint?.url?.absoluteString
    //        return venueEndpoint!
    //    }
    //
    //    func searchEndpointWithUserLocation(_ coord: Coordinate) -> String {
    //        var endpoint = URLComponents(string: "https://api.foursquare.com/v2/venues/search")
    //        endpoint?.queryItems = [
    //            URLQueryItem(name: "ll", value: "\(coord.lat),\(coord.lng)"),
    //        ]
    //        let venueEndpoint = endpoint?.url?.absoluteString
    //        return venueEndpoint!
    //    }
}
