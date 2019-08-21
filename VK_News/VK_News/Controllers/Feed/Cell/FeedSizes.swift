//
//  FeedSizes.swift
//  VK_News
//
//  Created by Vlad Suhomlinov on 21/08/2019.
//  Copyright © 2019 vlad. All rights reserved.
//

import UIKit

struct FeedSizes: FeedCellSizesProtocol {
    var attechmentHeight: CGFloat {
        guard let size = photoAttachment?.photo?.currentSize else {
            return 0
        }
        let ratio = CGFloat(Float(size.height) / Float(size.width))
        return ratio * width
    }
    private let width: CGFloat
    private let photoAttachment:  Attachment?
    
    init(width: CGFloat, photoAttachment: Attachment?) {
        self.width = width
        self.photoAttachment = photoAttachment
    }
}
