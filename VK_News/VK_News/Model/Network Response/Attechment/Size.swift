//
//  Size.swift
//  VK_News
//
//  Created by Vlad Suhomlinov on 21/08/2019.
//  Copyright © 2019 vlad. All rights reserved.
//

import Foundation

struct PhotoData: Decodable {
    let type: String
    let url: String
    let width: Int
    let height: Int
}
