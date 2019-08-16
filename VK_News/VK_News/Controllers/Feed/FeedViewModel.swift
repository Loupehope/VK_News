//
//  FeedViewModel.swift
//  VK_News
//
//  Created by Vlad on 15.08.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import Foundation

final class FeedViewModel {
    private let dataFetcher = FeedNetworkDataFetcher(networkService: FeedNetworkService())
    var onFeedChanged: ((Feed) -> Void)?
    
    func loadMore() {
        dataFetcher.getData { [onFeedChanged] (data) in
            guard let data = data else { return }
            onFeedChanged?(data)
        }
    }
    
}
