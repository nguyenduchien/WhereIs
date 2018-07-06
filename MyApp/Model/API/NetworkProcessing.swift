//
//  NetworkProcessing.swift
//  MyApp
//
//  Created by Hien Nguyen on 6/1/18.
//  Copyright © 2018 Hien Nguyen. All rights reserved.
//

import Foundation
// Input: URLRequest
// Output: returns JSON, or raw data
// Algo: Make request to server, download data, return data
  public let DANetworkingErrorDomain = "\(String(describing: Bundle.main.bundleIdentifier)).Networking Error"
  public let missingHTTPResponseError: Int = 10
  public let unexpectedResponseError: Int = 20

  class NetworkProcessing {

    let request: URLRequest
    lazy var configuration: URLSessionConfiguration = URLSessionConfiguration.default
    lazy var session: URLSession = URLSession(configuration: self.configuration)

    init(request: URLRequest) {
        self.request = request
    }

    typealias JSON = [String: Any]
    typealias JSONHandler = (JSON?, HTTPURLResponse?, Error?) -> Void
    typealias DataHandler = (Data?, HTTPURLResponse?, Error?) -> Void

    func downloadJSON(completion: @escaping JSONHandler) {
        let dataTask = session.dataTask(with: self.request) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                let userInfo: [String:Any] = [NSLocalizedDescriptionKey: NSLocalizedString("Missing HTTP Response", comment: "")]
                let error = NSError(domain: DANetworkingErrorDomain, code: missingHTTPResponseError, userInfo: userInfo)
                completion(nil, nil, error as Error)
                return
            }

            if data == nil {
                if let error = error as? URLError {
                    switch error {
                    case URLError.notConnectedToInternet:
                       print("Can not connect internet !")
                    default:
                        print("Other Error")
                    }
                    completion(nil, httpResponse, error)
                }
            } else {
                switch httpResponse.statusCode {
                case 200:
                    do { // MARK: GET JSON
                        guard let data = data else { return }
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? JSON
                        completion(json, httpResponse, nil)
                    } catch let error as NSError {
                        completion(nil, httpResponse, error)
                    }
                default:
                    print("Received HTTP response code: \(httpResponse.statusCode) - was not handled in NetworkProcessing.swift")
                }
            }
        }

        dataTask.resume()
    }

    func downloadData(completion: @escaping DataHandler) {

        let dataTask = session.dataTask(with: self.request) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                let userInfo: [String:Any] = [NSLocalizedDescriptionKey: NSLocalizedString("Missing HTTP Response", comment: "")]
                let error = NSError(domain: DANetworkingErrorDomain, code: missingHTTPResponseError, userInfo: userInfo)
                completion(nil, nil, error as Error)
                return
            }

            if data == nil {
                if let error = error {
                    completion(nil, httpResponse, error)
                }
            } else {
                switch httpResponse.statusCode {
                case 200: // MARK: GET DATA
                    completion(data, httpResponse, nil)
                default:
                    print("Received HTTP response code: \(httpResponse.statusCode) - was not handled in NetworkProcessing.swift")
                }
            }
        }
        dataTask.resume()
    }
}
