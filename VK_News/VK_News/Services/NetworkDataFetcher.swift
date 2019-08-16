//
//  NetworkDataFetcher.swift
//  VK_News
//
//  Created by Vlad on 16.08.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import Foundation

final class FeedNetworkDataFetcher: DataFetcher {
    private enum Const {
        static let params = ["filters": "post,photo"]
        static let path = "/method/newsfeed.get"
    }
    private let networkService: NetworkService
    private let authService = AppDelegate.shared().authService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getData(_ completionHandler: @escaping (Feed?) -> Void) {
        var allParams = Const.params.merging(API.version, uniquingKeysWith: { (_, value) in value })
        allParams[API.token] = authService.token
        networkService.request(path: Const.path, params: allParams) { [completionHandler] (data, error) in
            if error != nil { return }
            guard let data = data else { return }
            let decoder = JSONDecoder()
            let result = try? decoder.decode(Feed.self, from: data)
            completionHandler(result)
        }
        
    }
}
