//
//  FeedCellProtocol.swift
//  VK_News
//
//  Created by Vlad on 17.08.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import Foundation

protocol FeedCellProtocol {
    var onResponseTransformed: ((Post) -> Void)? { get set}
    
    func transform(response: Response, index: Int)
}
