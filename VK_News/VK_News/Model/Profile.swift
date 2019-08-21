//
//  Profile.swift
//  VK_News
//
//  Created by Vlad on 17.08.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import Foundation

struct Profile: Source, Decodable {
    private let firstName: String
    private let lastName: String
    private let photo50: String
    var id: Int
    var photo: String {
        return photo50
    }
    var title: String {
        return firstName + " " + lastName
    }
}
