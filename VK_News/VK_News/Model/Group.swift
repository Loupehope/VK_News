//
//  Group.swift
//  VK_News
//
//  Created by Vlad on 17.08.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import Foundation

struct Group: Source, Decodable {
    var id: Int
    var title: String
    var photo: String
    
    enum CodingKeys: String, CodingKey {
        case id, title = "name", photo = "photo_50"
    }
}
