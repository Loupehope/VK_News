//
//  FeedViewModel.swift
//  VK_News
//
//  Created by Vlad on 15.08.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import Foundation

final class FeedViewModel: FeedViewModelProtocol {
    private let feedService: FeedNetworkService
    var onFeedChanged: ((Feed) -> Void)?
    
    init(service: FeedNetworkService) {
        feedService = service
    }
    
    func loadMore() {
        feedService.load { [weak self] (feed) in
            guard let feed = feed else { return }
            self?.onFeedChanged?(feed)
        }
    }
    
}
