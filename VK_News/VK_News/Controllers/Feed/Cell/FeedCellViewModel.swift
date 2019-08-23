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
    private enum Content {
        case icon, imageAttechment
    }
    var toPostTransformed: ((Post) -> Void)?
    var onIconLoaded: ((UIImage) -> Void)?
    var onAttechmentsLoaded: ((UIImage) -> Void)?
    var onHeightChanged: ((CGFloat) -> Void)?
    
    private var imageService: ImageNetworkService
    
    init(service: ImageNetworkService) {
        imageService = service
    }
    
    func fetch(response: Response, at index: Int) {
        let item = response.items[index]
        let source = getSource(for: item, profiles: response.profiles, groups: response.groups)
        guard let attechment = item.attachments?.first else { return }
        transformToPost(from: source, item, and: attechment)
        load(content: .icon, for: source.photo)
        load(content: .imageAttechment, for: attechment.photo?.currentSize?.url ?? "")
    }
    
    // MARK: private
    
    private func transformToPost(from source: Source, _ item: Item, and attechment: Attachment) {
        let date = Date(timeIntervalSince1970: TimeInterval(item.date))
        let sizes = FeedSizes(width: UIScreen.main.bounds.width - 16, photoAttachment: attechment, text: item.text)
        let post = Post(source: source.title,
                        likesCount: "\(item.likes?.count ?? 0)",
                        commentsCount: "\(item.comments?.count ?? 0)",
                        repostsCount: "\(item.reposts?.count ?? 0)",
                        viewsCount: "\(item.views?.count ?? 0)",
                        date: DateFormatter.feedFormat.string(from: date),
                        text: item.text ?? "",
                        sizes: sizes)
        toPostTransformed?(post)
    }
    
    private func load(content: Content, for url: String) {
        imageService.url = url
        imageService.load { [weak self] (image) in
            guard let self = self else { return }
            guard let image = image else { return }
            switch content {
            case .icon:
                self.onIconLoaded?(image)
            case .imageAttechment:
                self.onAttechmentsLoaded?(image)
            }
        }
    }
    
    private func getSource(for item: Item, profiles: [Source], groups: [Source]) -> Source {
        let sources = item.sourceId > 0 ? profiles : groups
        let id = item.sourceId.abs()
        return sources.first(where: { (source) in
            source.id == id
        })!
    }
}
