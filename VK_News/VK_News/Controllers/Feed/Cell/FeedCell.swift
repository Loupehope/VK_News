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
    private let viewModel = FeedCellViewModel(service: ImageNetworkService())
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var iconImageView: UIImageView! {
        didSet {
            iconImageView.layer.cornerRadius = 10
            iconImageView.clipsToBounds = true
        }
    }
    @IBOutlet private var likesCountLabel: UILabel!
    @IBOutlet private var commentsCountLabel: UILabel!
    @IBOutlet private var repostsCountLabel: UILabel!
    @IBOutlet private var viewsCountLabel: UILabel!
    
    override func prepareForReuse() {
        titleLabel.text = String()
        dateLabel.text = String()
        likesCountLabel.text = String()
        commentsCountLabel.text = String()
        repostsCountLabel.text = String()
        viewsCountLabel.text = String()
        iconImageView.image = nil
        viewModel.cancelRequests()
    }
    
    override func awakeFromNib() {
        viewModel.onResponseTransformed = { [weak self] (source) in
            self?.titleLabel.text = source.source
            self?.dateLabel.text = source.date
            self?.likesCountLabel.text = source.likesCount
            self?.commentsCountLabel.text = source.commentsCount
            self?.repostsCountLabel.text = source.repostsCount
            self?.viewsCountLabel.text = source.viewsCount
        }
        viewModel.onIconLoaded = { [weak self] (icon) in
            self?.iconImageView.image = icon
        }
    }
    
    func set(with response: Response, for index: Int) {
        viewModel.transform(response: response, for: index)
        viewModel.loadIcon()
    }
    
}

// MARK: NibReusable

extension FeedCell: NibReusable {
    static var reuseIdentifier: String {
        return Const.cellId
    }
}


