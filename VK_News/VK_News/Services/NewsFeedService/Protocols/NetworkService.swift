//
//  NetworkService.swift
//  VK_News
//
//  Created by Vlad on 15.08.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import Foundation

protocol NetworkService {
    associatedtype Result
    
    func load(_ completionHandler: @escaping (Result?) -> Void)
}
