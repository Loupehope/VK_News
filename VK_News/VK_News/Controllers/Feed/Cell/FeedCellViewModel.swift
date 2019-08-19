//
//  FeedCellViewModel.swift
//  VK_News
//
//  Created by Vlad on 17.08.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import UIKit
import Alamofire

final class FeedCellViewModel: FeedCellProtocol {
    var onResponseTransformed: ((Post) -> Void)?
    var onIconLoaded: ((UIImage) -> Void)?
    private var imageURL = ""
    private var imageService: ImageNetworkService
    
    init(service: ImageNetworkService) {
        imageService = service
    }
    
    func cancelRequests() {
        Alamofire.SessionManager.default.session.getTasksWithCompletionHandler { [weak self] (_, _, downloadTasks) in
            downloadTasks.forEach {
                if ($0.originalRequest?.url?.absoluteString == self?.imageURL) {
                    print("deleted")
                    $0.cancel()
                }
            }}
    }
    
    func transform(response: Response, for index: Int) {
        let item = response.items[index]
        let date = Date(timeIntervalSince1970: TimeInterval(item.date))
        let source = getSource(for: item, profiles: response.profiles, groups: response.groups)
        imageURL = source.photo
        imageService.imageURL = source.photo
        let post = Post(source: source.title,
                        likesCount: "\(item.likes?.count ?? 0)",
                        commentsCount: "\(item.comments?.count ?? 0)",
                        repostsCount: "\(item.reposts?.count ?? 0)",
                        viewsCount: "\(item.views?.count ?? 0)",
                        date: DateFormatter.feedFormat.string(from: date))
        onResponseTransformed?(post)
    }
    
    func loadIcon() {
        imageService.load { [weak self] (image) in
            guard let image = image else { return }
            self?.onIconLoaded?(image)
        }
    }
    
    private func getSource(for item: Item, profiles: [Source], groups: [Source]) -> Source {
        let sources = item.sourceID > 0 ? profiles : groups
        let id = item.sourceID.abs()
        return sources.first(where: { (source) in
            source.id == id
        })!
    }
}
