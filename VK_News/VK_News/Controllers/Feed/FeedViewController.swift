//
//  FeedViewController.swift
//  VK_News
//
//  Created by Vlad on 15.08.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import Reusable
import UIKit

final class FeedViewController: UIViewController {
    private enum Const {
        static let storyboardName = "FeedViewController"
    }
    @IBOutlet private var tableView: UITableView!
    private let viewModel = FeedViewModel(service: FeedNetworkService())
    private var rowHeight: CGFloat = 0
    private var response: Response? {
        didSet {
            DispatchQueue.main.async { 
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(cellType: FeedCell.self)
        viewModel.onFeedChanged = { [weak self] feed in
            self?.response = feed.response
        }
        viewModel.loadMore()
    }
}

// MARK: UITableViewDataSource

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return response?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as FeedCell
        if let response = response {
            cell.set(with: response, for: indexPath.row) { height in
                self.rowHeight = height
            }
        }
        return cell
    }
}

// MARK: UITableViewDelegate

extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
}

// MARK: StoryboardSceneBased

extension FeedViewController: StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard {
        return UIStoryboard(name: Const.storyboardName, bundle: nil)
    }
}
