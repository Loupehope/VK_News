//
//  Item.swift
//  VK_News
//
//  Created by Vlad on 16.08.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import Foundation

struct Item: Decodable {
    let sourceId: Int
    let postId: Int
    let date: Int
    let text: String?
    let attachments: [Attachment]?
    let comments: CountableItem?
    let likes: CountableItem?
    let reposts: CountableItem?
    let views: CountableItem?
}
