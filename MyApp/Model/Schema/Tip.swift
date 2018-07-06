//
//  Tip.swift
//  MyApp
//
//  Created by Hien Nguyen on 6/20/18.
//  Copyright © 2018 Hien Nguyen. All rights reserved.
//

import Foundation

struct FourSquareTipObjectsJSON: Codable {
    let response: TipResponse
}

struct TipResponse: Codable {
    let tips: Tips
}

struct Tips: Codable {
    let count: Int //30 - # of tips
    let items: [TipObject]
}

struct TipObject: Codable {
    let text: String //"Had a frozen Hazelnut coffee, wasn't too sweet or too bitter.  Tasted just right.  Really liked it. Free wifi."
    let user: User
}
struct User: Codable {
    let firstName: String? // "Katrina"
    let lastName: String? //"Zai"
    let photo: Photo
}
struct Photo: Codable {
    let prefix: String //"https://igx.4sqi.net/img/user/"
    let suffix: String //"/9810645_YRduXs1l_zKPAQsx1DHlTTtR-kOJgkrSxB09nx5cXlZDRI8-pSsZqO8hpSNgHij4R-91z7_0x.jpg"
}
