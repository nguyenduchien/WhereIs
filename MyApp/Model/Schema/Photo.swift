//
//  Photo.swift
//  MyApp
//
//  Created by Hien Nguyen on 6/14/18.
//  Copyright © 2018 Hien Nguyen. All rights reserved.
//

import Foundation

struct FourSquarePhotoObjectsJSON: Codable {
    let response: PhotoResponse
}

struct PhotoResponse: Codable {
    let photos: Photos
}

struct Photos: Codable {
    let count: Int //30 - # of photos
    let items: [PhotoObject]
}

struct PhotoObject: Codable {
    let prefix: String //"https://igx.4sqi.net/img/general/"
    let suffix: String //"/26739064_mUxQ4CGrobFqwpcAIoX6YoAdH0xCDT4YAxaU6y65PPI.jpg"
}
