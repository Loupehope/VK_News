//
//  FeedViewModelProtocol.swift
//  VK_News
//
//  Created by Vlad on 19.08.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import Foundation

protocol FeedViewModelProtocol {
    var onFeedChanged: ((Feed) -> Void)? { get set }
    
    func loadMore()
}
