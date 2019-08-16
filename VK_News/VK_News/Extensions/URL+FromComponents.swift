//
//  URL+FromComponents.swift
//  VK_News
//
//  Created by Vlad on 15.08.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import Foundation

extension URL {
    static func generateURL(scheme: String, host: String, path: String?, params: [String: String]?) -> URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        if let params = params {
             components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        }
        if let path = path {
            components.path = path
        }
        return components.url
    }
}
