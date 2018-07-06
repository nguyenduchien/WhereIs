//
//  HomeViewModel.swift
//  MyApp
//
//  Created by Hien Nguyen on 6/4/18.
//  Copyright © 2018 Hien Nguyen. All rights reserved.
//

import Foundation
class HomeViewModel {
    var foursquareClient: FoursquareClient!
    func setupData() {
        // TO-DO: dummy data
        foursquareClient = FoursquareClient(clientId: FourSquareAPIKeys.clientId, clientSecret: FourSquareAPIKeys.clientSecret, oauthToken: FourSquareAPIKeys.oauthToken)
    }
}
