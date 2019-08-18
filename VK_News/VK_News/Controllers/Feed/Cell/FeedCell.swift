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
    private let viewModel = FeedCellViewModel() 
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var iconImageView: UIImageView!
    @IBOutlet private var likesCountLabel: UILabel!
    @IBOutlet private var commentsCountLabel: UILabel!
    @IBOutlet private var repostsCountLabel: UILabel!
    @IBOutlet private var viewsCountLabel: UILabel!
    
    override func awakeFromNib() {
        viewModel.onResponseTransformed = { [weak self] (source) in
            self?.titleLabel.text = source.source
            self?.dateLabel.text = source.date
            self?.iconImageView.image = source.icon
            self?.likesCountLabel.text = source.likesCount
            self?.commentsCountLabel.text = source.commentsCount
            self?.repostsCountLabel.text = source.repostsCount
            self?.viewsCountLabel.text = source.viewsCount
        }
    }
    
    func setResponseData(_ response: Response, for index: Int) {
        viewModel.transform(response: response, index: index)
    }
    
}

// MARK: NibReusable

extension FeedCell: NibReusable {
    static var reuseIdentifier: String {
        return Const.cellId
    }
}


