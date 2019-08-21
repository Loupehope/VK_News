//
//  ImageNetworkService.swift
//  VK_News
//
//  Created by Vlad on 18.08.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import Foundation
import Alamofire

final class ImageNetworkService: NetworkService {
    var url: String?
    
    func load(_ completionHandler: @escaping (UIImage?) -> Void) {
        guard let photoURL = URL(string: url ?? "") else { return }
        if let cachedImage = URLCache.shared.cachedResponse(for: URLRequest(url: photoURL)) {
            completionHandler(UIImage(data: cachedImage.data)!)
            return
        }
        
        Alamofire.request(photoURL).responseData {
            guard let response = $0.response else { return }
            switch $0.result {
            case let .success(data):
                DispatchQueue.main.async {
                    self.store(data: data, for: response)
                    completionHandler(UIImage(data: data)!)
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func store(data: Data, for response: URLResponse) {
        guard let url = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: url))
    }
}
