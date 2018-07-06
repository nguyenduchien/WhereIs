//
//  FourSquareAPIKeys.swift
//  MyApp
//
//  Created by Hien Nguyen on 6/7/18.
//  Copyright © 2018 Hien Nguyen. All rights reserved.
//

import Foundation
struct FourSquareAPIKeys {
    static let clientId = "F5Y0VXSBIPMVBI4Q5QRAN5TDV4K1OFWWRJZJYEBFTSYS5EZH"
    static let clientSecret = "35DXSALNKRNCFK0ZEYXYVQCYJINYKX434AQ2EQPPQYPHMR5Z"
    static let oauthToken = "ITPR5WTYUTY3KEACYE3OMLZ5RH5DYPCXD3DNF1TOIWMUZN3S"
    static let todaysDate = Date().description.prefix(10).replacingOccurrences(of: "-", with: "")
    static let fourSquareAuthorizationClient = "&client_id=\(FourSquareAPIKeys.clientId)&client_secret=\(FourSquareAPIKeys.clientSecret)&v=\(FourSquareAPIKeys.todaysDate)"
    static let fourSquareAuthorizationToken = "&oauth_token=\(FourSquareAPIKeys.oauthToken)&v=\(FourSquareAPIKeys.todaysDate)"
}
