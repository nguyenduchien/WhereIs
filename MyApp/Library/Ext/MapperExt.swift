//
//  Mapper.swift
//  MyApp
//
//  Created by iOSTeam on 2/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

extension Mapper {

    func mapObj(result: Result<Any>, completion: (Result<N>) -> Void) {
        switch result {
        case .success(let json):
            guard let obj = json as? JSObject else {
                completion(.failure(Api.Error.json))
                return
            }
            guard let object = Mapper<N>().map(JSON: obj) else {
                completion(.failure(Api.Error.emptyData))
                return
            }
            completion(.success(object))
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
