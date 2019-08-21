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
    var toPostTransformed: ((Post) -> Void)?
    var onIconLoaded: ((UIImage) -> Void)?
    var onAttechmentsLoaded: ((UIImage) -> Void)?
    private var imageService: ImageNetworkService
    private var item: Item!
    
    init(service: ImageNetworkService) {
        imageService = service
    }
    
    func fetch(response: Response, at index: Int) {
        let item = response.items[index]
        let source = getSource(for: item, profiles: response.profiles, groups: response.groups)
        transformToPost(from: source, and: item)
        loadIcon(for: source.photo)
        loadAttechmentImages(for: getPhotoURL(from: item.attachments ?? []) ?? "")
        
        
    }
    
    private func getPhotoURL(from attechments: [Attachment]) -> String? {
        guard let attechment = attechments.first else { return nil }
        return attechment.photo?.currentSize?.url
    }
    
    private func transformToPost(from source: Source, and item: Item) {
        let date = Date(timeIntervalSince1970: TimeInterval(item.date))
        let post = Post(source: source.title,
                        likesCount: "\(item.likes?.count ?? 0)",
                        commentsCount: "\(item.comments?.count ?? 0)",
                        repostsCount: "\(item.reposts?.count ?? 0)",
                        viewsCount: "\(item.views?.count ?? 0)",
                        date: DateFormatter.feedFormat.string(from: date),
                        text: item.text ?? "")
        toPostTransformed?(post)
    }
    
    private func loadIcon(for url: String) {
        imageService.imageURL = url
        imageService.load { [weak self] (image) in
            guard let image = image else { return }
            self?.onIconLoaded?(image)
        }
    }
    
    private func loadAttechmentImages(for url: String) {
        imageService.imageURL = url
        imageService.load { [weak self] (image) in
            guard let image = image else { return }
            self?.onAttechmentsLoaded?(image)
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
