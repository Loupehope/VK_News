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
    var textHeight: CGFloat {
        guard let text = text else { return 0 }
        return text.height(width: width, font: .systemFont(ofSize: 15))
    }
    private let width: CGFloat
    private let photoAttachment:  Attachment?
    private let text: String?
    
    init(width: CGFloat, photoAttachment: Attachment?, text: String?) {
        self.width = width
        self.photoAttachment = photoAttachment
        self.text = text
    }
}

extension String {
    func height(width: CGFloat, font: UIFont) -> CGFloat {
        let textSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        let attrib = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]
        let size  = self.boundingRect(with: textSize,
                                      options: .usesLineFragmentOrigin,
                                      attributes: attrib,
                                      context: nil)
        return ceil(size.height)
    }
}
