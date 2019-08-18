//
//  Profile.swift
//  VK_News
//
//  Created by Vlad on 17.08.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import Foundation

struct Profile: Source, Decodable {
    var id: Int
    var photo: String
    var title: String {
        return firstname + " " + lastname
    }
    let firstname: String
    let lastname: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstname = "first_name"
        case lastname = "last_name"
        case photo = "photo_50"
    }
}
