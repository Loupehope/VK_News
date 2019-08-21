//
//  Photo.swift
//  VK_News
//
//  Created by Vlad Suhomlinov on 21/08/2019.
//  Copyright © 2019 vlad. All rights reserved.
//

import Foundation

struct Photo: Decodable {
    var currentSize: PhotoData? {
        return getPropperSize()
    }
    private var sizes: [PhotoData]
    
    private func getPropperSize() -> PhotoData? {
        if let data = sizes.first(where: { $0.type == "x" }) {
            return PhotoData(type: data.type, url: data.url, width: data.width, height: data.height)
        } else if let last = sizes.last {
            return PhotoData(type: last.type, url: last.url, width: last.width, height: last.height)
        }
        return nil
    }
    
}
