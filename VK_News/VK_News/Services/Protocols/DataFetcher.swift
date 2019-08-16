//
//  DataFetcher.swift
//  VK_News
//
//  Created by Vlad on 16.08.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import Foundation

protocol DataFetcher {
    associatedtype Result
    
    func getData(_ completionHandler: @escaping (Result?) -> Void)
}
