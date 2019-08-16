//
//  FeedCell.swift
//  VK_News
//
//  Created by Vlad on 16.08.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import UIKit
import Reusable

final class FeedCell: UITableViewCell {
    private enum Const {
        static let cellId = "FeedCell"
    }
}

// MARK: NibReusable

extension FeedCell: NibReusable {
    static var reuseIdentifier: String {
        return Const.cellId
    }
}


