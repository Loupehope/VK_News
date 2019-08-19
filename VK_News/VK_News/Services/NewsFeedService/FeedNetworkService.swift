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
    private let authService = AppDelegate.shared().authService
    
    func load(_ completionHandler: @escaping (Feed?) -> Void) {
        let api = NewsFeedAPI(token: authService.token)
        guard let feedURL = URL.generateURL(scheme: api.scheme,
                                            host: api.host,
                                            path: api.path,
                                            params: api.headers) else { return }
        Alamofire.request(feedURL).responseData {
            switch $0.result {
            case let .success(data):
                let result = try? JSONDecoder().decode(Feed.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(result)
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
