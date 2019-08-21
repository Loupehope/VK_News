//
//  Response.swift
//  VK_News
//
//  Created by Vlad on 16.08.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import Foundation

struct Response: Decodable {
    let items: [Item]
    let profiles: [Profile]
    let groups: [Group]
}
