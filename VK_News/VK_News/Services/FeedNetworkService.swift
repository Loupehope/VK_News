//
//  FeedNetworkService.swift
//  VK_News
//
//  Created by Vlad on 15.08.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import Foundation
import Alamofire

final class FeedNetworkService: NetworkService {
    private enum Const {
        static let params = ["filter": "post,photo"]
    }
    
    func request(path: String, params: [String : String], _ completionHandler: @escaping (Data?, Error?) -> Void) {
        guard let feedURL = URL.generateURL(scheme: API.scheme,
                                            host: API.host,
                                            path: path,
                                            params: params) else { return }
        Alamofire.request(feedURL).responseData {
            switch $0.result {
            case let .success(data):
                DispatchQueue.main.async {
                    completionHandler(data, nil)
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
