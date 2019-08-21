//
//  Source.swift
//  VK_News
//
//  Created by Vlad on 17.08.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import Foundation

protocol Source {
    var id: Int { get }
    var title: String { get }
    var photo: String { get }
}
