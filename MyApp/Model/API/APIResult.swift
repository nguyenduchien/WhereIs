//
//  APIResult.swift
//  MyApp
//
//  Created by Hien Nguyen on 6/1/18.
//  Copyright © 2018 Hien Nguyen. All rights reserved.
//

import Foundation
enum APIResult<T> {
    case success(T)
    case failure(Error)
}
