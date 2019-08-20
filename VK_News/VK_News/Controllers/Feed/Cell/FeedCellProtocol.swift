//
//  FeedCellProtocol.swift
//  VK_News
//
//  Created by Vlad on 17.08.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import UIKit

protocol FeedCellProtocol {
    var onResponseTransformed: ((Post) -> Void)? { get set}
    var onIconLoaded: ((UIImage) -> Void)? { get set}
    
    func loadIcon()
    func transform(response: Response, for index: Int)
    func cancelRequests()
}
