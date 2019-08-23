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
        static let insect: CGFloat = 150
    }
    private let viewModel = FeedCellViewModel(service: ImageNetworkService())
    @IBOutlet private var backView: UIView! {
        didSet {
            backView.layer.cornerRadius = 10
            backView.clipsToBounds = true
        }
    }
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var iconImageView: UIImageView! {
        didSet {
            iconImageView.layer.cornerRadius = 15
            iconImageView.clipsToBounds = true
        }
    }
    @IBOutlet private var feedTextLabel: UILabel!
    @IBOutlet private var likesCountLabel: UILabel!
    @IBOutlet private var commentsCountLabel: UILabel!
    @IBOutlet private var repostsCountLabel: UILabel!
    @IBOutlet private var viewsCountLabel: UILabel!
    @IBOutlet private var attechmentImageView: UIImageView!
    private var rowHeight: CGFloat?
    
    override func prepareForReuse() {
        attechmentImageView.image = nil
        iconImageView.image = nil
    }
    
    override func awakeFromNib() {
        viewModel.toPostTransformed = { [weak self] (source) in
            self?.titleLabel.text = source.source
            self?.dateLabel.text = source.date
            self?.likesCountLabel.text = source.likesCount
            self?.commentsCountLabel.text = source.commentsCount
            self?.repostsCountLabel.text = source.repostsCount
            self?.viewsCountLabel.text = source.viewsCount
            self?.feedTextLabel.text = source.text
            self?.rowHeight = source.sizes.attechmentHeight + source.sizes.textHeight + Const.insect
        }
        viewModel.onIconLoaded = { [weak self] (icon) in
            self?.iconImageView.image = icon
        }
        viewModel.onAttechmentsLoaded = { [weak self] (image) in
            self?.attechmentImageView.image = image
        }
    }
    
    func set(with response: Response, for index: Int, _ completionHandler: (CGFloat) -> Void) {
        viewModel.fetch(response: response, at: index)
        completionHandler(self.rowHeight ?? 0)
    }
}

// MARK: NibReusable

extension FeedCell: NibReusable {
    static var reuseIdentifier: String {
        return Const.cellId
    }
}


