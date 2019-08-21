//
//  Group.swift
//  VK_News
//
//  Created by Vlad on 17.08.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import Foundation

struct Group: Source, Decodable {
    private let name: String
    private let photo50: String
    var id: Int
    var title: String {
        return name
    }
    var photo: String {
        return photo50
    }
}
