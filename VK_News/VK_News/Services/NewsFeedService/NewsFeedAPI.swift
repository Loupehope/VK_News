//
//  NewsFeedAPI.swift
//  VK_News
//
//  Created by Vlad on 15.08.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import Foundation

struct NewsFeedAPI {
    private var token: String
    var path: String {
        return "/method/newsfeed.get"
    }
    var scheme: String {
        return "https"
    }
    var host: String {
        return "api.vk.com"
    }
    var headers: [String: String]? {
        return ["access_token": token, "v": "5.101", "filters": "post,photo"]
    }

    init(token: String) {
        self.token = token
    }
}
