//
//  FeedCellProtocol.swift
//  VK_News
//
//  Created by Vlad on 17.08.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import UIKit

protocol FeedCellProtocol {
    var toPostTransformed: ((Post) -> Void)? { get set }
    var onIconLoaded: ((UIImage) -> Void)? { get set }
    var onAttechmentsLoaded: ((UIImage) -> Void)? { get set }
    
    func fetch(response: Response, at index: Int)
}
