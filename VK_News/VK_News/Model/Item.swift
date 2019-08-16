//
//  Item.swift
//  VK_News
//
//  Created by Vlad on 16.08.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import Foundation

struct Item: Decodable {
    let sourceID: Int
    let postId: Int
    let date: Int
    let text: String
    let comments: CountableItem
    let likes: CountableItem
    let reposts: CountableItem
    let views: CountableItem
    
    enum CodingKeys: String, CodingKey {
        case sourceID = "source_id"
        case postId = "post_id"
        case date, text, comments, likes, reposts, views
    }
}
