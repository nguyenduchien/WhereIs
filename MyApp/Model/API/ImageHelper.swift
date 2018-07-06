//
//  ImageHelper.swift
//  MyApp
//
//  Created by Hien Nguyen on 6/15/18.
//  Copyright © 2018 Hien Nguyen. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

enum AppError {
    case badURL
}
// Image Helper - get images from online
struct ImageHelper {
    private init() {}
    static let manager = ImageHelper()
    func getImage(from urlStr: String,
                  completionHandler: @escaping (Data) -> Void,
                  errorHandler: @escaping (AppError) -> Void) {
        guard let url = URL(string: urlStr) else { errorHandler(.badURL); return }
        // Check if data already exists
//        if let savedImage = FileManagerHelper.manager.getUIImage(with: urlStr) {
//            completionHandler(savedImage)
//            return
//        }
        // Network call to get image
        Alamofire.request(url).responseData { (response) in
            guard response.result.isSuccess else { fatalError("This url don't work bruh") }
            guard let data = response.data else { fatalError("where the data at") }
            // Save to Filemanager
//            FileManagerHelper.manager.saveUIImage(with: urlStr, image: image) //Is this always persisted and why?
            completionHandler(data)
        }
    }
}
